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
  import MarkdownIt from "markdown-it";
  const md = new MarkdownIt();

  export let slug;

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
  {@html md.render(text)}

  <hr />

  <details>
    <summary>Raw:</summary>
    <pre>{text}</pre>
  </details>

</div>
