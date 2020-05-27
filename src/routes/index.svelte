<script>
  import { a, b, esc, unesc } from "../util";
  import { onMount } from "svelte";
  import pako from "pako";
  import CryptoJS from "crypto-js";

  let value = "";

  const d = plain => {
    return b(pako.deflate(plain, { to: "string" }));
  };
  const i = bbbb => {
    return pako.inflate(a(bbbb), { to: "string" });
  };

  onMount(() => {
    if (typeof localStorage !== undefined) {
      value = localStorage.getItem("value");
    }
    if (!value) {
      value = "You can share this text as a link";
    }
  });

  const handleInput = e => {
    if (typeof localStorage !== undefined) {
      localStorage.setItem("value", value);
    }
  };

  let addPass = false;
  let password = "";
  let link;

  $: b64 = b(esc(value));
  $: b64s = unesc(a(b64));
  $: z = d(value);
  $: zs = i(z);
  $: percentage = Math.floor(link.length / 20);
  $: ciphertext = CryptoJS.AES.encrypt(value, password).toString();
  $: ciphertext3 = CryptoJS.AES.encrypt(z, password).toString();
  // $: decoded = CryptoJS.AES.decrypt(ciphertext, password).toString(
  //   CryptoJS.enc.Utf8
  // );
  // $: decoded3 = i(
  //   CryptoJS.AES.decrypt(ciphertext3, password).toString(CryptoJS.enc.Utf8)
  // );
  // $: link = b64.length < z.length ? `/.${b64}` : `/${z}`;
  $: {
    if (addPass) {
      link =
        ciphertext.length < ciphertext3.length
          ? `/:.${ciphertext}`
          : `/:${ciphertext3}`;
    } else {
      link = b64.length < z.length ? `/.${b64}` : `/${z}`;
    }
  }
</script>

<style>

</style>

<svelte:head>
  <title>Text in a link</title>
</svelte:head>

<textarea name="input" cols="30" rows="10" bind:value on:input={handleInput} />
<p>{percentage}%</p>
{#if percentage > 100}
  <p>Link may not work in all browsers</p>
{/if}

<label>
  <input type="checkbox" bind:checked={addPass} />
  Add password
</label>
{#if addPass}
  <input type="password" bind:value={password} />
{/if}
<br />
<br />
<a rel="prefetch" href={link}>Share link</a>
<!-- <p>{ciphertext.length} - {ciphertext}</p>
<p>{decoded}</p>
<p>{ciphertext3.length} - {ciphertext3}</p>
<p>{decoded3}</p> -->
<!-- <p>{b64.length} {b64}</p> -->
<!-- <p>{b64s}</p> -->
<!-- <p>{z.length} {z}</p> -->
<!-- <p>{zs}</p> -->

<!-- {#await z}
  <p>...waiting</p>
{:then number}
  <p>The number is {number}</p>
{:catch error}
  <p style="color: red">{error.message}</p>
{/await} -->
<!-- <p>{Buffer.from(str).toString("base64")}</p> -->
