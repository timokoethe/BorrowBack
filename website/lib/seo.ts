import type { Metadata } from "next";

export const SITE_URL = "https://borrowback.itstimo.me";
export const SITE_NAME = "BorrowBack";
export const SITE_TITLE = "BorrowBack – Track lent items on your iPhone";
export const SITE_DESCRIPTION =
  "Keep track of items you lend, who has them, and when they are due. BorrowBack is a free iPhone app with a return archive and private iCloud sync.";
export const SITE_AUTHOR = {
  name: "Timo Köthe",
  url: "https://itstimo.me/",
};
export const SITE_AUTHOR_ID = "https://itstimo.me/#person";
export const SOFTWARE_ID = `${SITE_URL}/#software`;
export const WEBSITE_ID = `${SITE_URL}/#website`;
export const WEBPAGE_ID = `${SITE_URL}/#webpage`;

// Set the real App Store URL here when the listing is available.
// Buttons and structured download data use this same value.
export const APP_STORE_URL: string | null = null;

export function createPageMetadata({
  title,
  description,
  path,
}: {
  title: string;
  description: string;
  path: string;
}): Metadata {
  return {
    title,
    description,
    alternates: { canonical: path },
    openGraph: {
      title,
      description,
      url: path,
      siteName: SITE_NAME,
      locale: "en_US",
      type: "website",
      images: [{
        url: "/og.png",
        width: 1200,
        height: 640,
        alt: "BorrowBack – Track lent items on your iPhone",
      }],
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ["/og.png"],
    },
  };
}

export function homeStructuredData() {
  return {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "WebSite",
        "@id": WEBSITE_ID,
        name: SITE_NAME,
        alternateName: "BorrowBack for iPhone",
        url: `${SITE_URL}/`,
        author: { "@id": SITE_AUTHOR_ID },
        inLanguage: "en",
      },
      {
        "@type": "WebPage",
        "@id": WEBPAGE_ID,
        name: SITE_TITLE,
        description: SITE_DESCRIPTION,
        url: `${SITE_URL}/`,
        isPartOf: { "@id": WEBSITE_ID },
        mainEntity: { "@id": SOFTWARE_ID },
        inLanguage: "en",
      },
      {
        "@type": "SoftwareApplication",
        "@id": SOFTWARE_ID,
        name: SITE_NAME,
        description: SITE_DESCRIPTION,
        url: `${SITE_URL}/`,
        mainEntityOfPage: { "@id": WEBPAGE_ID },
        image: `${SITE_URL}/icon.png`,
        operatingSystem: "iOS 26 or later",
        applicationCategory: "UtilitiesApplication",
        author: { "@type": "Person", "@id": SITE_AUTHOR_ID, ...SITE_AUTHOR },
        featureList: [
          "Track lent items, borrowers, and due dates",
          "Keep optional notes about accessories, condition, or return arrangements",
          "Link a borrower with the system contact picker",
          "Edit reminders for linked contacts, then send by SMS/iMessage or copy the text",
          "Archive returned loans and restore them",
          "Sync loan records through private iCloud",
        ],
        ...(APP_STORE_URL ? {
          downloadUrl: APP_STORE_URL,
          installUrl: APP_STORE_URL,
          sameAs: [APP_STORE_URL],
          offers: { "@type": "Offer", price: 0, priceCurrency: "USD", url: APP_STORE_URL },
        } : {}),
      },
    ],
  };
}
