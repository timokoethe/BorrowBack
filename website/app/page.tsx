import { SiteHeader } from "./components/SiteHeader";
import { SiteFooter } from "./components/SiteFooter";
import { StoreButton } from "./components/StoreButton";
import Image from "next/image";
import {
  ArrowRight,
  BellRing,
  ContactRound,
  Check,
  Infinity as InfinityIcon,
  MessageCircle,
  Plus,
  ShieldCheck,
  Sparkles,
  WifiOff,
} from "lucide-react";
import appIcon from "./icon.png";
import { DeviceFrame } from "./components/DeviceFrame";
import {
  APP_STORE_URL,
  createPageMetadata,
  homeStructuredData,
  SITE_DESCRIPTION,
  SITE_TITLE,
} from "@/lib/seo";

export const metadata = createPageMetadata({
  title: SITE_TITLE,
  description: SITE_DESCRIPTION,
  path: "/",
});

const steps = [
  {
    title: "Add the loan",
    text: "Record the item, who has it, and when it should come back. Type a name or link a contact.",
  },
  {
    title: "Follow up when it matters",
    text: "See which loans are due soon or overdue. Sort by due date to see what needs attention first.",
  },
  {
    title: "Record the return",
    text: "Mark a returned item with a swipe. It moves to the archive and can be restored if the return was recorded by mistake.",
  },
];

const followUpFeatures = [
  {
    icon: ContactRound,
    title: "Link the right person",
    text: "Choose a borrower from your contacts or type a name. BorrowBack only receives details from the contact you select.",
  },
  {
    icon: MessageCircle,
    title: "Write a reminder",
    text: "Open a suggested message with the item and due date already filled in. Edit it to make it your own.",
  },
  {
    icon: BellRing,
    title: "Stay in control",
    text: "Review the message before sending it by SMS or iMessage, or copy the text to use in another app. Nothing is sent automatically.",
  },
];

const promises = [
  {
    icon: WifiOff,
    title: "Private by design",
    text: "Your loans are stored on your iPhone and can sync through your private iCloud account. We cannot access your loan records.",
  },
  {
    icon: ShieldCheck,
    title: "No BorrowBack account needed",
    text: "Start with your first loan. The app has no analytics and does not track your activity.",
  },
  {
    icon: InfinityIcon,
    title: "Every feature is free",
    text: "The full app is free, with no subscriptions, in-app purchases, or ads.",
  },
];

const faq = [
  {
    q: "Which devices and iOS versions are supported?",
    a: "BorrowBack is designed for iPhone and requires iOS 26 or later. The app is available in English and German and follows your app or system language settings.",
  },
  {
    q: "Where is my data stored?",
    a: "Locally on your iPhone, in the app's own database. When iCloud is enabled for BorrowBack, your loans also sync through your private iCloud account so they stay up to date across your devices. We cannot access your loan records.",
  },
  {
    q: "Do I need iCloud?",
    a: "No. BorrowBack works locally without iCloud. When iCloud is enabled for BorrowBack in your device settings, your loans sync automatically across devices signed in to the same Apple Account. There is no separate sync switch in the app.",
  },
  {
    q: "Does BorrowBack support accessibility features?",
    a: "Yes. BorrowBack supports VoiceOver and Voice Control, so you can manage your loans using spoken feedback or voice commands.",
  },
  {
    q: "What does BorrowBack cost?",
    a: "BorrowBack is free to download and use. All features are included, with no subscriptions, in-app purchases, or ads.",
  },
  {
    q: "Does it work offline?",
    a: "Yes. You can view and change your loans without a network connection. If iCloud is enabled for BorrowBack, offline changes sync after you reconnect.",
  },
  {
    q: "Does BorrowBack send reminders automatically?",
    a: "No. You choose when to write a reminder. For an active loan linked to a contact with a phone number, BorrowBack prepares an editable message with the item and due date. You review the message and confirm sending it by SMS or iMessage, or copy the text to use elsewhere.",
  },
  {
    q: "Can I copy a reminder if my device cannot send messages?",
    a: "Yes. Copy remains available even when your device cannot send SMS or iMessage. It copies just the message text, ready to paste into another app. Reminders require an active loan linked to a contact with a phone number.",
  },
  {
    q: "What happens to returned items?",
    a: "A swipe marks a loan as returned and moves it to the archive, where you can look up when the item was lent and returned.",
  },
];


export default function Home() {
  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify(homeStructuredData()).replace(/</g, "\\u003c"),
        }}
      />
      <SiteHeader home />

      <main id="top">
        <section className="shell hero">
          <div>
            <p className="hero-meta">
              <Sparkles size={14} strokeWidth={2} aria-hidden="true" />
              Free · No account · iPhone
            </p>
            <h1 className="display">
              Never forget what you <span className="accent">lent.</span>
            </h1>
            <p className="lead">
              Keep track of what you&rsquo;ve lent, who has it, and when it&rsquo;s due back.
              From books to camping gear, your loans stay in one place.
            </p>
            <div className="hero-actions">
              <StoreButton />
              <a className="btn btn--quiet" href="#how">
                How it works
                <ArrowRight size={16} strokeWidth={2} aria-hidden="true" />
              </a>
            </div>
            <ul className="facts">
              <li>
                <Check size={15} strokeWidth={2.4} aria-hidden="true" />
                Works offline
              </li>
              <li>
                <Check size={15} strokeWidth={2.4} aria-hidden="true" />
                No sign-up
              </li>
              <li>
                <Check size={15} strokeWidth={2.4} aria-hidden="true" />
                Private iCloud sync
              </li>
            </ul>
          </div>

          <div className="hero-stage">
            <DeviceFrame
              screenshot="HomeView"
              alt="The BorrowBack overview, listing four active loans with their due dates"
              placement="hero"
              preload
            />
          </div>
        </section>

        <section className="section shell" id="how">
          <span className="eyebrow">How it works</span>
          <h2 className="display">
            Add it. Follow up.
            <br />
            Get it back.
          </h2>
          <div className="steps" style={{ marginTop: "3rem" }}>
            {steps.map((step, index) => (
              <article className="step" key={step.title}>
                <span className="step-index">{String(index + 1).padStart(2, "0")}</span>
                <h3>{step.title}</h3>
                <p>{step.text}</p>
              </article>
            ))}
          </div>
        </section>

        <section className="section shell">
          <div className="split">
            <div>
              <span className="eyebrow">Adding a loan</span>
              <h2 className="display">
                Only the details
                <br />
                that help it come back.
              </h2>
              <p className="prose lead">
                Record what you lent, who has it, when it went out, and when you want it back.
                Type a name or choose a borrower from your contacts.
              </p>
              <ul className="checklist">
                <li>
                  <Plus size={17} strokeWidth={2.2} aria-hidden="true" />
                  Record a loan today or add one you made earlier
                </li>
                <li>
                  <BellRing size={17} strokeWidth={2.2} aria-hidden="true" />
                  Choose a return date one or two weeks after the loan date, or pick your own
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Add optional notes about accessories, condition or return arrangements
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Open an active loan later to correct its details or extend the due date
                </li>
              </ul>
            </div>
            <div className="split-visual">
              <DeviceFrame
                screenshot="AddView"
                alt="The New Loan screen with fields for item, person and return date"
              />
            </div>
          </div>
        </section>

        <section className="section shell">
          <div className="centered">
            <span className="eyebrow">Following up</span>
            <h2 className="display">
              A thoughtful reminder,
              <br />
              <span className="accent">ready when you need it.</span>
            </h2>
            <p className="lead">
              Choose when to follow up with a message you can edit before sending.
              Reminders are available for active loans linked to a contact with a phone number.
            </p>
          </div>
          <div className="card-grid">
            {followUpFeatures.map(({ icon: Icon, title, text }) => (
              <article className="card" key={title}>
                <Icon size={22} strokeWidth={1.8} aria-hidden="true" />
                <h3>{title}</h3>
                <p>{text}</p>
              </article>
            ))}
          </div>
        </section>

        <section className="section shell">
          <div className="split split--reverse">
            <div>
              <span className="eyebrow">After the return</span>
              <h2 className="display">
                A history of
                <br />
                <span className="accent">what came back.</span>
              </h2>
              <p className="prose lead">
                Marking something as returned clears it from your overview but keeps it in the
                archive, with the date it went out and the date it came back.
              </p>
              <ul className="checklist">
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Mark a loan as returned with a swipe
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Find the most recently returned items at the top of the archive
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Restore an archived loan if you marked it as returned by mistake
                </li>
              </ul>
            </div>
            <div className="split-visual">
              <DeviceFrame
                screenshot="ArchiveView"
                alt="The archive, listing items that have already been returned"
              />
            </div>
          </div>
        </section>

        <section className="section shell" id="privacy">
          <div className="centered">
            <span className="eyebrow">Privacy</span>
            <h2 className="display">
              Everything you need.
              <br />
              <span className="accent">Nothing you don&rsquo;t.</span>
            </h2>
            <p className="lead">
              BorrowBack keeps the focus on your loans. Your records stay on your devices
              and in your private iCloud account when sync is enabled.
            </p>
          </div>
          <div className="card-grid">
            {promises.map(({ icon: Icon, title, text }) => (
              <article className="card" key={title}>
                <Icon size={22} strokeWidth={1.8} aria-hidden="true" />
                <h3>{title}</h3>
                <p>{text}</p>
              </article>
            ))}
          </div>
        </section>

        <section className="section shell" id="faq">
          <span className="eyebrow">FAQ</span>
          <h2 className="display">Questions, answered.</h2>
          <div className="faq-list">
            {faq.map((item) => (
              <details className="faq-item" key={item.q}>
                <summary>
                  {item.q}
                  <Plus size={18} strokeWidth={2} aria-hidden="true" />
                </summary>
                <p>{item.a}</p>
              </details>
            ))}
          </div>
        </section>

        <section className="section shell" id="download">
          <div className="cta">
            <Image src={appIcon} alt="The BorrowBack app icon" width={84} height={84} />
            <div>
              <span className="eyebrow">Free. Private. Yours.</span>
              <h2 className="display">Lend it. Track it. Get it back.</h2>
              <p>
                {APP_STORE_URL
                  ? "BorrowBack is a free download for iPhone."
                  : "BorrowBack is coming soon to the App Store as a free iPhone app."}
                {" "}No account, no subscription. Requires iOS 26 or later.
              </p>
            </div>
            <StoreButton variant="onDark" />
          </div>
        </section>
      </main>

      <SiteFooter home />
    </>
  );
}
