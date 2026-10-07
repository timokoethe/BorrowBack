import { createPageMetadata } from "@/lib/seo";
import Image from "next/image";
import Link from "next/link";
import appIcon from "../icon.png";

export const metadata = createPageMetadata({
  title: "Privacy Policy — BorrowBack",
  description:
    "How the BorrowBack iPhone app and this website handle data, including optional iCloud synchronization of loan records.",
  path: "/privacy",
});

const lastUpdated = "7 October 2026";

export default function PrivacyPage() {
  return (
    <>
      <a className="skip-link" href="#privacy">
        Skip to privacy policy
      </a>

      <header className="legal-header">
        <Link className="brand" href="/" aria-label="BorrowBack home">
          <Image src={appIcon} alt="" width={34} height={34} priority />
          BorrowBack
        </Link>
      </header>

      <main className="legal-page" id="privacy">
        <p className="eyebrow">Legal</p>
        <h1 className="display">Privacy Policy</h1>
        <p className="legal-lead">
          BorrowBack is a free iPhone app for keeping track of items you lend.
          This Privacy Policy explains how BorrowBack (&ldquo;BorrowBack,&rdquo;
          &ldquo;we,&rdquo; &ldquo;us,&rdquo; or &ldquo;our&rdquo;) handles
          information when you use the app and this website. The short version:
          your loan records are stored on your device and may also be stored in
          your private iCloud account to keep them synchronized across your
          devices. We do not receive or have access to those records.
        </p>

        <section aria-labelledby="collect-title">
          <h2 id="collect-title">Information we collect</h2>
          <p>
            The app has no BorrowBack account, analytics, advertising, or
            developer-operated backend. It may use Apple&apos;s iCloud service to
            synchronize your data across devices signed in to your Apple Account.
            Apart from this optional synchronization, your app data remains on
            your device and is not sent to us:
          </p>
          <ul>
            <li>
              <strong>Loan records</strong> — item titles, borrower names, loan
              and due dates, return dates, and the information needed to keep
              active and archived loans available between app launches. These
              records are stored locally and may also be stored in a private
              iCloud database for synchronization. We never receive or have
              access to these records.
            </li>
            <li>
              <strong>Selected contacts</strong> — if you choose a borrower with
              the system contact picker, the app stores that contact&apos;s display
              name and identifier with the loan, plus one phone number if the
              contact has one. If the contact has multiple phone numbers, you
              choose which number to store. BorrowBack cannot browse your
              contacts database and receives no details about contacts you do not
              select. If iCloud synchronization is used, the stored name,
              identifier, and phone number may be synchronized as part of the
              loan record.
            </li>
            <li>
              <strong>Website log data</strong> — opening a page on this site
              produces standard server logs at our hosting provider, including
              your IP address, the requested URL, the time of the request, and
              your browser&apos;s user agent.
            </li>
            <li>
              <strong>Website analytics</strong> — this website uses Vercel Web
              Analytics to record page views. Data may include the page URL,
              referrer, filtered query parameters, timestamp, approximate
              location, and browser, operating system, and device type. Vercel
              provides aggregated statistics and uses a request-derived hash
              to distinguish visitors without cookies or identification across
              websites. Loan records and selected contacts are not part of this
              website analytics.
            </li>
          </ul>
        </section>

        <section aria-labelledby="use-title">
          <h2 id="use-title">How we use information</h2>
          <p>
            For a loan linked to a contact with a stored phone number, you can
            prepare an SMS or iMessage reminder. BorrowBack passes that number
            and a suggested message containing the item title and due date to
            the system message composer. You can edit or cancel the message;
            it is sent only when you confirm sending. If you send it, the
            message is shared with the recipient through Apple&apos;s iMessage
            service or your mobile carrier, depending on the message type.
            We do not receive the phone number or message content.
          </p>
          <p>
            iCloud data is used only to keep your loan records available and up
            to date across your devices. We do not use that data for analytics,
            advertising, profiling, or any other purpose and cannot access it.
          </p>
          <p>
            Server log data is used only to deliver this website and keep it
            secure, on the basis of our legitimate interest under Art. 6(1)(f)
            GDPR. It is not combined with anything else and is not used to
            identify you or build a profile. We do not sell personal information
            or use it for advertising.
          </p>
          <p>
            Website analytics helps us understand which pages people visit and
            improve the site. We do not use it for advertising or combine it
            with app data. Vercel describes its data handling in its{" "}
            <a href="https://vercel.com/docs/analytics/privacy-policy">
              Web Analytics privacy documentation
            </a>.
          </p>
        </section>

        <section aria-labelledby="providers-title">
          <h2 id="providers-title">Service providers</h2>
          <p>
            This website is hosted by Vercel Inc., which also provides Web
            Analytics and processes the website log and analytics data described
            above under a data processing agreement.
            Apple distributes the app through the App Store and handles that
            relationship under its own privacy policy. If iCloud synchronization
            is used, Apple also transmits and stores the synchronized app data in
            your iCloud account under Apple&apos;s terms and{" "}
            <a href="https://www.apple.com/legal/privacy/">Privacy Policy</a>.
            We do not operate the iCloud infrastructure and cannot access the
            private records stored there.
          </p>
        </section>

        <section aria-labelledby="retention-title">
          <h2 id="retention-title">Retention and deletion</h2>
          <p>
            You can delete individual loan records in the app at any time.
            When iCloud synchronization is used, deletions may be synchronized
            across your devices. Deleting the app from one device removes its
            local data but may not delete records that remain in iCloud or on
            another device. You can manage iCloud storage and synchronization in
            your Apple device settings. Server logs expire according to our
            hosting provider&apos;s retention schedule. We hold no user database, so
            there is no app data for us to delete on your behalf.
          </p>
          <p>
            Vercel discards the analytics visitor session after 24 hours; this
            does not mean all page-view statistics are deleted after 24 hours.
            Analytics reporting windows depend on the Vercel plan, and Vercel
            may retain statistics beyond that window, as explained in its{" "}
            <a href="https://vercel.com/docs/analytics/limits-and-pricing#what-is-the-reporting-window">
              reporting-window documentation
            </a>.
          </p>
        </section>

        <section aria-labelledby="security-title">
          <h2 id="security-title">Security and international processing</h2>
          <p>
            This site is served over encrypted connections. Because Vercel is
            based in the United States, website log and analytics data may be
            transferred to a third country; that transfer is safeguarded by the
            EU Standard Contractual Clauses included in Vercel&apos;s data
            processing agreement. Apple protects iCloud data according to its own
            security practices and may process it in the locations described in
            its Privacy Policy. No system is completely secure.
          </p>
        </section>

        <section aria-labelledby="rights-title">
          <h2 id="rights-title">Your choices and rights</h2>
          <p>
            Under the GDPR you have the right to access, rectification, erasure,
            restriction of processing, data portability, and objection, and you
            may lodge a complaint with a supervisory authority. In practice we
            hold no app data that identifies you and cannot access data stored on
            your device or in your private iCloud account. You can manage that
            data through the app, your device settings, and Apple. A request to
            us can therefore concern the website log and analytics data
            described above. We cannot identify an individual visitor in the
            aggregated analytics statistics available to us.
          </p>
        </section>

        <section aria-labelledby="children-title">
          <h2 id="children-title">Children&apos;s privacy</h2>
          <p>
            The BorrowBack app sends no personal information to us;
            if iCloud synchronization is used, app data is stored by Apple in the
            user&apos;s iCloud account. BorrowBack contains no advertising, tracking,
            public sharing, or social features.
          </p>
        </section>

        <section aria-labelledby="contact-title">
          <h2 id="contact-title">Contact us</h2>
          <p>
            For questions, feedback, or feature requests, please open a{" "}
            <a href="https://github.com/timokoethe/BorrowBack/issues">
              GitHub issue
            </a>{" "}
            or email us at{" "}
            <a href="mailto:borrowback@itstimo.me">borrowback@itstimo.me</a>.
          </p>
        </section>

        <p className="legal-updated">Last updated: {lastUpdated}</p>
      </main>
    </>
  );
}
