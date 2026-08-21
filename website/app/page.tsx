import Image from "next/image";
import {
  Archive,
  ArrowRight,
  BellRing,
  CalendarDays,
  CalendarClock,
  Check,
  CheckCircle2,
  ChevronDown,
  Clock3,
  Gift,
  House,
  Infinity as InfinityIcon,
  LockKeyhole,
  MoreHorizontal,
  PackageCheck,
  Plus,
  Search,
  ShieldCheck,
  Sparkles,
  UserRound,
  WifiOff,
} from "lucide-react";
import appIcon from "./icon.png";

const features = [
  { icon: Clock3, title: "Added in seconds", text: "Item, person, and due date — done." },
  { icon: CalendarClock, title: "Due dates at a glance", text: "See right away what should come back soon." },
  { icon: PackageCheck, title: "Returned with a swipe", text: "Move returned items neatly into your archive." },
  { icon: LockKeyhole, title: "Private by design", text: "Your loans stay locally on your device." },
];

const details = [
  { icon: WifiOff, title: "100% local", text: "Works offline. Your data stays with you." },
  { icon: ShieldCheck, title: "No account", text: "No sign-up, no tracking, no profile." },
  { icon: InfinityIcon, title: "Completely free", text: "No paywalls, subscriptions, or hidden costs." },
];

const loans = [
  { icon: "⌨", title: "Magic Keyboard", person: "Lena Hoffmann", date: "Aug 24", status: "Due soon", tone: "amber" },
  { icon: "◉", title: "Camera", person: "Jonas Richter", date: "Sep 2", status: "On track", tone: "teal" },
  { icon: "⌁", title: "Travel guide", person: "Mara Klein", date: "Aug 18", status: "Overdue", tone: "coral" },
];

function AppStoreButton({ compact = false }: { compact?: boolean }) {
  return (
    <a className={`store-button${compact ? " store-button--compact" : ""}`} href="#download" aria-label="Download BorrowBack on the App Store">
      <span className="apple-mark" aria-hidden="true"></span>
      <span><small>Download on the</small><strong>App Store</strong></span>
    </a>
  );
}

function PhonePreview() {
  return (
    <div className="phone-wrap" aria-label="Preview of the BorrowBack app">
      <div className="phone">
        <div className="phone-screen">
          <div className="dynamic-island" />
          <div className="phone-status"><span>9:41</span><span>● ● ●</span></div>
          <div className="app-heading">
            <div><span className="eyebrow">Good morning</span><h3>BorrowBack</h3></div>
            <button aria-label="Add a new loan"><Plus size={19} strokeWidth={2.5} /></button>
          </div>
          <div className="overview-row"><strong>Your loans</strong><span>Due date <ChevronDown size={12} /></span></div>
          <div className="loan-list">
            {loans.map((loan) => (
              <article className="loan-card" key={loan.title}>
                <div className="loan-art" aria-hidden="true">{loan.icon}</div>
                <div className="loan-copy">
                  <h4>{loan.title}</h4>
                  <p><UserRound size={11} />{loan.person}</p>
                  <p><CalendarDays size={11} />{loan.date}</p>
                  <span className={`status status--${loan.tone}`}>{loan.status}</span>
                </div>
              </article>
            ))}
          </div>
          <nav className="tabbar" aria-label="App-Navigation">
            <span className="is-active"><House size={15} fill="currentColor" />Overview</span>
            <span><Archive size={15} />Archive</span>
            <span><MoreHorizontal size={15} />More</span>
          </nav>
        </div>
      </div>
    </div>
  );
}

export default function Home() {
  return (
    <main>
      <header className="site-header shell">
        <a className="brand" href="#top" aria-label="BorrowBack home page">
          <Image src={appIcon} alt="" width={38} height={38} priority />
          <span>BorrowBack</span>
        </a>
        <nav className="site-nav" aria-label="Main navigation">
          <a href="#features">Features</a><a href="#privacy">Privacy</a><a href="#faq">FAQ</a>
        </nav>
        <AppStoreButton compact />
      </header>

      <section className="hero shell" id="top">
        <div className="hero-copy">
          <div className="kicker"><Sparkles size={14} /> Private. Simple. Reliable.</div>
          <h1>Never forget<br />what you <span>lent.</span></h1>
          <p className="hero-lead">BorrowBack remembers the things you lend, so you don’t have to. No account, no subscription, and no unnecessary clutter.</p>
          <div className="hero-actions"><AppStoreButton /><a className="text-link" href="#features">See how it works <ArrowRight size={16} /></a></div>
          <div className="trust-row"><span><Check size={15} /> Free to download</span><span><Check size={15} /> Made for iPhone</span><span><Check size={15} /> No account</span></div>
        </div>
        <div className="hero-visual">
          <div className="hero-glow" />
          <div className="float-card float-card--top"><BellRing size={18} /><span><strong>Due soon</strong>Magic Keyboard</span></div>
          <PhonePreview />
          <div className="float-card float-card--bottom"><CheckCircle2 size={20} /><span><strong>Returned</strong>Archived instantly</span></div>
        </div>
      </section>

      <section className="feature-rail shell" id="features" aria-label="Key features">
        {features.map(({ icon: Icon, title, text }) => <article key={title}><span className="feature-icon"><Icon size={21} /></span><div><h2>{title}</h2><p>{text}</p></div></article>)}
      </section>

      <section className="clarity shell">
        <div className="clarity-card"><div className="mini-window" aria-hidden="true">
          <div className="mini-top"><Search size={16} /><span>Overview</span><Plus size={16} /></div>
          <div className="mini-loan"><Gift /><span><strong>Picnic blanket</strong><small>With Sophie · due Sep 3</small></span><b>OK</b></div>
          <div className="mini-loan"><Archive /><span><strong>Cordless drill</strong><small>With Paul · due tomorrow</small></span><b className="warn">Soon</b></div>
        </div></div>
        <div className="clarity-copy">
          <span className="section-label">Everything at a glance</span>
          <h2>Lent out.<br /><em>Not forgotten.</em></h2>
          <p>A calm overview shows you what is currently out and when it should come back.</p>
          <ul><li><CheckCircle2 /> Active loans neatly sorted</li><li><CheckCircle2 /> Clear cues for items due soon</li><li><CheckCircle2 /> Returned items stay in your archive</li></ul>
        </div>
      </section>

      <section className="privacy shell" id="privacy">
        <div className="privacy-heading"><span className="section-label">Less app. More peace of mind.</span><h2>Everything you need.<br /><em>Nothing you don’t.</em></h2></div>
        <div className="detail-grid">{details.map(({ icon: Icon, title, text }) => <article key={title}><span><Icon /></span><h3>{title}</h3><p>{text}</p></article>)}</div>
      </section>

      <section className="download shell" id="download">
        <div className="download-icon"><Image src={appIcon} alt="BorrowBack App Icon" width={88} height={88} /></div>
        <div><span className="section-label">Free. Simple. Yours.</span><h2>Lending should feel simple.</h2><p>BorrowBack is completely free to use. No subscriptions, no ads.</p></div>
        <AppStoreButton />
      </section>

      <section className="faq shell" id="faq">
        <span className="section-label">Quick answers</span><h2>Frequently asked questions</h2>
        <div className="faq-grid"><article><h3>Where is my data stored?</h3><p>Directly and locally on your iPhone. BorrowBack does not require an account.</p></article><article><h3>How much does BorrowBack cost?</h3><p>Nothing. BorrowBack is completely free, with no subscriptions or ads.</p></article></div>
      </section>

      <footer className="footer shell">
        <a className="brand" href="#top"><Image src={appIcon} alt="" width={32} height={32} /><span>BorrowBack</span></a>
        <p>Lend it. Track it. Get it back.</p>
        <nav aria-label="Footer navigation"><a href="#privacy">Privacy</a><a href="mailto:hello@borrowback.app">Contact</a></nav>
      </footer>
    </main>
  );
}
