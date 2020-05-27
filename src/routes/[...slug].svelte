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
  import CryptoJS from "crypto-js";
  const md = new MarkdownIt();

  export let slug;

  let error;
  let ciphertext;
  let plaintext;
  let password = "";
  let encrypted = false;

  const decrypt = (ciphertext, password) => {
    let result = "Provide correct password";
    try {
      
      if (ciphertext.startsWith(".")) {
        result =
          
          CryptoJS.AES.decrypt(ciphertext.slice(1), password).toString(
            CryptoJS.enc.Utf8
          ) || result;
      } else {
        result =
          pako.inflate(
            Buffer.from(
              CryptoJS.AES.decrypt(ciphertext, password).toString(
                CryptoJS.enc.Utf8
              ),
              "base64"
            ),
            { to: "string" }
          ) || result;
      }
    } catch (err) {
      // error = "Wrong password";
    }
    return result;
  };

  try {
    if (slug.startsWith(":")) {
      // this is encrypted
      encrypted = true;
      ciphertext = slug.slice(1);
    } else {
      if (slug.startsWith(".")) {
        plaintext = unesc(a(slug.slice(1)));
      } else {
        plaintext = pako.inflate(Buffer.from(slug, "base64"), { to: "string" });
      }
    }
  } catch (err) {
    error = err;
  }

  $: text = encrypted ? decrypt(ciphertext, password) : plaintext;
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
  {#if error}
    <p>{error}</p>
  {/if}

  {@html md.render(text)}

  <br />

  {#if encrypted}
    <label>
      Password:
      <input type="password" bind:value={password} />
    </label>
  {/if}

  <hr />

  <details>
    <summary>Raw:</summary>
    <pre>{text}</pre>
  </details>

</div>
