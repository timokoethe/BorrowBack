# BorrowBack Website

This directory contains the separate Next.js website for BorrowBack.
The native app itself is iOS-only and lives in [`../app/apple`](../app/apple).

The website is BorrowBack's project landing page. It introduces the native app,
shows its current features, and explains the project's development status.

## Getting Started

Install dependencies if needed, then run the development server:

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

Edit the main page in [`app/page.tsx`](app/page.tsx).

## Relationship to the App

Keep website messaging aligned with the current iOS app state. BorrowBack
remains under active development and currently runs from source. Do not
advertise App Store availability until a public App Store URL exists.

## Scripts

```bash
npm run dev
npm run build
npm run lint
```
