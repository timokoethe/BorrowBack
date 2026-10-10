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
    text: "See what is due soon or overdue, then prepare a reminder for a linked contact without retyping the details.",
  },
  {
    title: "Archive — or undo",
    text: "Mark a returned item with a swipe. It moves to the archive and can be restored if the return was recorded by mistake.",
  },
];

const followUpFeatures = [
  {
    icon: ContactRound,
    title: "Link the right person",
    text: "Choose someone with the system contact picker or simply type a name. BorrowBack cannot browse your contacts.",
  },
  {
    icon: MessageCircle,
    title: "Write a reminder",
    text: "For a linked contact with a phone number, BorrowBack prepares an editable SMS or iMessage with the item and due date.",
  },
  {
    icon: BellRing,
    title: "Stay in control",
    text: "Nothing is sent automatically. You review and confirm every reminder in the system message composer.",
  },
];

const promises = [
  {
    icon: WifiOff,
    title: "Private by design",
    text: "Your loans stay available on your iPhone and can sync through your private iCloud account. BorrowBack cannot access your records.",
  },
  {
    icon: ShieldCheck,
    title: "No account, no tracking",
    text: "No sign-up, no email, no analytics, no profile. Open the app and start.",
  },
  {
    icon: InfinityIcon,
    title: "Free, without the catch",
    text: "No subscription, no paywalled features, no ads. The whole app is the free version.",
  },
];

const faq = [
  {
    q: "Which devices and iOS versions are supported?",
    a: "BorrowBack is designed for iPhone and requires iOS 26 or later. The app is available in English and German and follows your app or system language settings.",
  },
  {
    q: "Where is my data stored?",
    a: "Locally on your iPhone, in the app's own database. When iCloud is available, your loans also sync through your private iCloud account so they stay up to date across your devices. BorrowBack cannot access your records.",
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
    a: "Nothing. There is no subscription, no in-app purchase and no advertising. Every feature is available from the moment you install it.",
  },
  {
    q: "Does it work offline?",
    a: "Yes. You can view and change your loans without a network connection. Changes made offline sync through iCloud after you reconnect.",
  },
  {
    q: "Does BorrowBack send reminders automatically?",
    a: "No. For an active loan linked to a contact with a phone number, touch and hold the loan, then choose Write reminder to prepare an SMS or iMessage. BorrowBack fills in the item and due date, and you can edit or cancel the message. It is sent only when you confirm sending in the system message composer.",
  },
  {
    q: "What happens to returned items?",
    a: "A swipe marks a loan as returned and moves it to the archive, where it stays with its loan and return date in case you need to look it up later.",
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
              BorrowBack keeps a quiet list of the things you have lent out and when they are
              due back — so the drill, the book and the camping stove all find their way home.
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
                Type a name or link the borrower from the system contact picker.
              </p>
              <ul className="checklist">
                <li>
                  <Plus size={17} strokeWidth={2.2} aria-hidden="true" />
                  The loan date defaults to today but can be moved into the past
                </li>
                <li>
                  <BellRing size={17} strokeWidth={2.2} aria-hidden="true" />
                  Pick seven days, fourteen days, or a custom due date
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
              Link a borrower once and BorrowBack can prepare the message when a return date is
              getting close — or has already passed.
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
                Returned, not
                <br />
                <span className="accent">deleted.</span>
              </h2>
              <p className="prose lead">
                Marking something as returned clears it from your overview but keeps it in the
                archive, with the date it went out and the date it came back.
              </p>
              <ul className="checklist">
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Swipe right to return, swipe left to delete for good
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  The archive stays sorted by most recently returned
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
              BorrowBack is deliberately small. There is no BorrowBack account to create, no
              advertising profile and no upsell waiting a few screens in.
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
