import type { Metadata, Viewport } from "next";
import { Analytics } from "@vercel/analytics/next"
import { SITE_AUTHOR, SITE_NAME, SITE_TITLE, SITE_URL } from "@/lib/seo";
import { Inter, Source_Serif_4 } from "next/font/google";
import "./globals.css";

/* Text face for the interface, serif for display headings — the serif echoes
   the app, whose own title is set in SwiftUI's serif design. */
const sans = Inter({
  subsets: ["latin"],
  variable: "--font-sans",
  display: "swap",
});

const serif = Source_Serif_4({
  subsets: ["latin"],
  weight: ["600", "700"],
  variable: "--font-serif",
  display: "swap",
});

export const viewport: Viewport = {
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#f7f3ec" },
    { media: "(prefers-color-scheme: dark)", color: "#14120f" },
  ],
};

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: SITE_TITLE,
  applicationName: SITE_NAME,
  authors: [SITE_AUTHOR],
  creator: SITE_AUTHOR.name,
  publisher: SITE_AUTHOR.name,
  robots: { index: true, follow: true },
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="en"
      className={`${sans.variable} ${serif.variable} antialiased`}
      data-scroll-behavior="smooth"
    >
      <body>{children}
        <Analytics />
      </body>
    </html>
  );
}
