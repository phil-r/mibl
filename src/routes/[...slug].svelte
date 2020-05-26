<script context="module">
  import { a, b, esc, unesc } from "../util";

  export async function preload({ params, query }) {
    const slug = params.slug.join("/");
    return { slug };
  }
</script>

<script>
  import pako from "pako";
  import { Buffer } from "buffer";
  // import marked from "marked";
  import MarkdownIt from "markdown-it";
  const md = new MarkdownIt();
  // import sanitizeHtml from 'sanitize-html';

  export let slug;
  console.log(slug);

  let text;
  try {
    if (slug.startsWith(".")) {
      text = unesc(a(slug.slice(1)));
    } else {
      text = pako.inflate(Buffer.from(slug, "base64"), { to: "string" });
    }
  } catch (error) {
    text = error;
  }
</script>

<style>
  /*
		By default, CSS is locally scoped to the component,
		and any unused styles are dead-code-eliminated.
		In this page, Svelte can't know which elements are
		going to appear inside the {{{post.html}}} block,
		so we have to use the :global(...) modifier to target
		all elements inside .content
	*/
  .content :global(h2) {
    font-size: 1.4em;
    font-weight: 500;
  }

  .content :global(pre) {
    background-color: #f9f9f9;
    box-shadow: inset 1px 1px 5px rgba(0, 0, 0, 0.05);
    padding: 0.5em;
    border-radius: 2px;
    overflow-x: auto;
  }

  .content :global(pre) :global(code) {
    background-color: transparent;
    padding: 0;
  }

  .content :global(ul) {
    line-height: 1.5;
  }

  .content :global(li) {
    margin: 0 0 0.5em 0;
  }
</style>

<svelte:head>
  <title>{text}</title>
</svelte:head>

<div class="content">
  <!-- {@html sanitizeHtml(marked(text))} -->
  {@html md.render(text)}

  <hr />

  <details>
    <summary>Raw:</summary>
    <pre>{text}</pre>
  </details>

  <!-- <h1>Sanitized:</h1>

  <pre>{sanitizeHtml(marked(text))}</pre> -->

</div>
