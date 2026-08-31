import Image from "next/image";
import {
  ArrowRight,
  BellRing,
  Check,
  Infinity as InfinityIcon,
  Plus,
  ShieldCheck,
  Sparkles,
  WifiOff,
} from "lucide-react";
import appIcon from "./icon.png";
import { DeviceFrame } from "./components/DeviceFrame";
import { AddLoanScreen, ArchiveScreen, OverviewScreen } from "./components/AppScreens";

const steps = [
  {
    title: "Add it in seconds",
    text: "Item, person, due date. Three fields and the sheet closes again.",
  },
  {
    title: "See what is out",
    text: "One list, sorted by return date, with a quiet badge for anything due soon.",
  },
  {
    title: "Swipe when it is back",
    text: "A returned item moves straight into the archive, out of your way.",
  },
];

const promises = [
  {
    icon: WifiOff,
    title: "Stays on your iPhone",
    text: "Everything is stored locally. No server holds your loans, so there is nothing to sync or leak.",
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
    q: "Where is my data stored?",
    a: "Locally on your iPhone, in the app's own database. BorrowBack has no backend and no account system, so your loans never leave the device.",
  },
  {
    q: "What does BorrowBack cost?",
    a: "Nothing. There is no subscription, no in-app purchase and no advertising. Every feature is available from the moment you install it.",
  },
  {
    q: "Does it work offline?",
    a: "Always. Because there is no server involved, the app behaves exactly the same in airplane mode as it does at home.",
  },
  {
    q: "What happens to returned items?",
    a: "A swipe marks a loan as returned and moves it to the archive, where it stays with its loan and return date in case you need to look it up later.",
  },
];

function StoreButton({ variant = "primary" }: { variant?: "primary" | "onDark" | "sm" }) {
  const className =
    variant === "sm"
      ? "btn btn--ghost btn--sm"
      : variant === "onDark"
        ? "btn btn--onDark"
        : "btn btn--primary";

  return (
    <a className={className} href="#download">
      <span className="glyph" aria-hidden="true">
        
      </span>
      Download on the App Store
    </a>
  );
}

export default function Home() {
  return (
    <>
      <header className="header">
        <div className="shell header-inner">
          <a className="brand" href="#top" aria-label="BorrowBack, back to top">
            <Image src={appIcon} alt="" width={30} height={30} priority />
            BorrowBack
          </a>
          <nav className="nav" aria-label="Main navigation">
            <a href="#how">How it works</a>
            <a href="#privacy">Privacy</a>
            <a href="#faq">FAQ</a>
          </nav>
          <StoreButton variant="sm" />
        </div>
      </header>

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
                Nothing leaves your phone
              </li>
            </ul>
          </div>

          <div className="hero-stage">
            <DeviceFrame screenshot="overview" alt="The BorrowBack overview, listing three active loans with their due dates">
              <OverviewScreen />
            </DeviceFrame>
          </div>
        </section>

        <section className="section shell" id="how">
          <span className="eyebrow">How it works</span>
          <h2 className="display">
            Three taps in.
            <br />
            One swipe out.
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
                No forms to fill.
                <br />
                Just the three things that matter.
              </h2>
              <p className="prose lead">
                What you lent, who has it, when you want it back. The keyboard is already up
                when the sheet opens, and a single tap saves it.
              </p>
              <ul className="checklist">
                <li>
                  <Plus size={17} strokeWidth={2.2} aria-hidden="true" />
                  Two fields and a date — nothing optional to worry about
                </li>
                <li>
                  <BellRing size={17} strokeWidth={2.2} aria-hidden="true" />
                  Due dates default to two weeks out, and adjust with one tap
                </li>
                <li>
                  <Check size={17} strokeWidth={2.4} aria-hidden="true" />
                  Sorted into your overview the moment you save
                </li>
              </ul>
            </div>
            <div className="split-visual">
              <DeviceFrame screenshot="add-loan" alt="The New Loan sheet with fields for item, person and return date">
                <AddLoanScreen />
              </DeviceFrame>
            </div>
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
                  Overdue items are flagged the moment the day turns over
                </li>
              </ul>
            </div>
            <div className="split-visual">
              <DeviceFrame screenshot="archive" alt="The archive, listing items that have already been returned">
                <ArchiveScreen />
              </DeviceFrame>
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
              BorrowBack is deliberately small. There is no account to create, no cloud to trust
              and no upsell waiting a few screens in.
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
                BorrowBack is a free download for iPhone. No account, no subscription, no
                reason to think about it again.
              </p>
            </div>
            <StoreButton variant="onDark" />
          </div>
        </section>
      </main>

      <footer className="footer">
        <div className="shell footer-inner">
          <a className="brand" href="#top">
            <Image src={appIcon} alt="" width={26} height={26} />
            BorrowBack
          </a>
          <p style={{ margin: 0 }}>© {new Date().getFullYear()} BorrowBack</p>
          <nav aria-label="Footer navigation">
            <a href="#privacy">Privacy</a>
            <a href="#faq">FAQ</a>
            <a href="mailto:hello@borrowback.app">Contact</a>
          </nav>
        </div>
      </footer>
    </>
  );
}
