<script>
 	import {a, b, esc, unesc} from '../util';
	import { onMount } from 'svelte';
	import pako from "pako";
	

  const d = plain => {
    return b(pako.deflate(plain, { to: "string" }));
	};
	const i = bbbb => {
		return pako.inflate(a(bbbb), { to: "string" });
	}

	onMount(() => {
	});


  let value = "You can share this text as a link";
  $: b64 = b(esc(value));
  $: b64s = unesc(a(b64));
  $: z = d(value);
	$: zs = i(z);
	$: link = b64.length < z.length ? `/.${b64}` : `/${z}`
</script>

<style>
</style>

<svelte:head>
  <title>Text in a link</title>
</svelte:head>

<textarea name="input" id="" cols="30" rows="10" bind:value />
<br>
<a rel=prefetch href={link}>Share link</a>
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
