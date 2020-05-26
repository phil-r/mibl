import querystring from 'querystring';

export let b =
  typeof btoa !== 'undefined' ? btoa : (s) => Buffer.from(s).toString('base64');

export let a =
  typeof atob !== 'undefined'
    ? atob
    : (s) => Buffer.from(s, 'base64').toString('utf-8');

export let esc = typeof escape !== 'undefined' ? escape : querystring.escape;
export let unesc =
  typeof unescape !== 'undefined' ? unescape : querystring.unescape;
