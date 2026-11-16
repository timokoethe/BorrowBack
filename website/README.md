# BorrowBack Website

This directory contains the separate Next.js website for BorrowBack.
The native app itself is iOS-only and lives in [`../app/apple`](../app/apple).

The website is BorrowBack's project landing page. It introduces the native app,
shows its current features, and links to its App Store listing.

## Getting Started

Install dependencies if needed, then run the development server:

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

Edit the main page in [`app/page.tsx`](app/page.tsx).

## Relationship to the App

Keep website messaging aligned with the current iOS app state. BorrowBack is
available as a free iPhone app on the App Store. The shared App Store URL in
`lib/seo.ts` powers the download buttons and structured download data.

## Scripts

```bash
npm run dev
npm run build
npm run lint
npm run typecheck
```

`typecheck` uses TypeScript 7 through the `@typescript/native` npm alias.
The `typescript` alias provides Microsoft's TypeScript 6 compatibility API for
ESLint and Next.js tooling. This follows Microsoft's
[side-by-side setup](https://devblogs.microsoft.com/typescript/announcing-typescript-7-0/#running-side-by-side-with-typescript-6.0)
while typescript-eslint requires the TypeScript 6 API.
Next.js currently uses that compatibility package for its build-time type check.
