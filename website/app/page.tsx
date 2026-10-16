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
    text: "Save what you lent, who has it, and when it is due back.",
  },
  {
    title: "Follow up when it matters",
    text: "Spot loans that are due soon or overdue.",
  },
  {
    title: "Record the return",
    text: "Swipe to mark an item as returned and keep it in your archive.",
  },
];

const followUpFeatures = [
  {
    icon: ContactRound,
    title: "Link the right person",
    text: "For an active loan, link a contact with a phone number. If several numbers are available, choose one for reminders. BorrowBack only receives details from the contact you select.",
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
    q: "Where is my data stored, and do I need iCloud?",
    a: "Your loans are stored on your iPhone and work without iCloud. If iCloud is enabled for BorrowBack in your device settings, they also sync through your private iCloud account across devices signed in to the same Apple Account. We cannot access your loan records.",
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
    q: "How do reminders work?",
    a: "You choose when to write a reminder. For an active loan linked to a contact with a phone number, BorrowBack prepares an editable message with the item and due date. You confirm sending it by SMS or iMessage, or copy the text to use elsewhere. Copy also works when your device cannot send messages. Nothing is sent automatically.",
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
          <div className="steps">
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
                Type a borrower&rsquo;s name or choose a contact, then set a due date.
                Add notes for the details you want to remember.
              </p>
              <ul className="checklist">
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Record today&rsquo;s loan or one you made earlier
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Update the details or extend the due date later
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
          <div className="reminder-panel">
            <div className="reminder-heading">
              <span className="eyebrow">Following up</span>
              <h2 className="display">
                A thoughtful reminder,
                <br />
                <span className="accent">ready when you need it.</span>
              </h2>
              <p className="lead">
                Choose when to follow up with a message you can edit before sending.
              </p>
            </div>
            <div className="reminder-details">
              <ol className="reminder-steps">
                {followUpFeatures.map(({ icon: Icon, title, text }) => (
                  <li key={title}>
                    <Icon size={21} strokeWidth={1.8} aria-hidden="true" />
                    <div>
                      <h3>{title}</h3>
                      <p>{text}</p>
                    </div>
                  </li>
                ))}
              </ol>
            </div>
            <div className="reminder-visual">
              <DeviceFrame
                screenshot="ReminderView"
                alt="An editable reminder for a camera due today, with Send and Copy buttons"
              />
            </div>
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
                Returned loans stay in your archive with their loan and return dates,
                newest returns first. Restore a loan if you marked it as returned by mistake.
              </p>
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
