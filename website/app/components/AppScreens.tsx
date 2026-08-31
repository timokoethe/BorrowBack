import {
  Archive,
  Calendar,
  Check,
  ChevronDown,
  Ellipsis,
  House,
  Package,
  Plus,
  User,
  X,
} from "lucide-react";

/** iOS points, resolved against the `--pt` scale on `.device`. Applied via
 *  inline style rather than SVG width/height so `calc()` actually works. */
const pt = (n: number) => `calc(${n} * var(--pt))`;
const box = (n: number) => ({ width: pt(n), height: pt(n), flex: "none" });

function StatusBar() {
  return (
    <div className="appui-status">
      <span>9:41</span>
      <span className="appui-status-icons" aria-hidden="true">
        <Signal />
        <Wifi />
        <Battery />
      </span>
    </div>
  );
}

function Signal() {
  return (
    <svg style={{ width: pt(18), height: pt(12), flex: "none" }} viewBox="0 0 18 12" fill="currentColor">
      <rect x="0" y="8" width="3" height="4" rx="1" />
      <rect x="5" y="5.5" width="3" height="6.5" rx="1" />
      <rect x="10" y="3" width="3" height="9" rx="1" />
      <rect x="15" y="0" width="3" height="12" rx="1" />
    </svg>
  );
}

function Wifi() {
  return (
    <svg style={{ width: pt(16), height: pt(12), flex: "none" }} viewBox="0 0 16 12" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round">
      <path d="M1 4.2a10 10 0 0 1 14 0" />
      <path d="M3.6 7a6.4 6.4 0 0 1 8.8 0" />
      <path d="M6.2 9.7a2.7 2.7 0 0 1 3.6 0" />
    </svg>
  );
}

function Battery() {
  return (
    <svg style={{ width: pt(25), height: pt(12), flex: "none" }} viewBox="0 0 25 12" fill="none">
      <rect x="0.6" y="0.6" width="21" height="10.8" rx="3.2" stroke="currentColor" strokeOpacity="0.4" strokeWidth="1" />
      <rect x="2.2" y="2.2" width="15" height="7.6" rx="2" fill="currentColor" />
      <path d="M23 4.2v3.6a2 2 0 0 0 0-3.6Z" fill="currentColor" fillOpacity="0.4" />
    </svg>
  );
}

function TabBar({ active }: { active: "overview" | "archive" }) {
  return (
    <div className="appui-tabs" aria-hidden="true">
      <span data-active={active === "overview"}>
        <House style={box(24)} strokeWidth={2} fill={active === "overview" ? "currentColor" : "none"} />
        Overview
      </span>
      <span data-active={active === "archive"}>
        <Archive style={box(24)} strokeWidth={2} />
        Archive
      </span>
      <span data-active={false}>
        <Ellipsis style={box(24)} strokeWidth={2} />
        More
      </span>
    </div>
  );
}

type Loan = {
  title: string;
  person: string;
  date: string;
  status: string;
  tone: "ok" | "soon" | "late";
};

function LoanCard({ loan }: { loan: Loan }) {
  return (
    <article className="appui-card">
      <div className="appui-thumb" aria-hidden="true">
        <Package style={box(52)} strokeWidth={1.6} />
      </div>
      <div className="appui-info">
        <h5>{loan.title}</h5>
        <p>
          <User style={box(16)} strokeWidth={1.8} />
          {loan.person}
        </p>
        <p>
          <Calendar style={box(16)} strokeWidth={1.8} />
          {loan.date}
        </p>
        <span className="appui-badge" data-tone={loan.tone}>
          {loan.status}
        </span>
      </div>
    </article>
  );
}

const activeLoans: Loan[] = [
  { title: "Cordless drill", person: "Tobias Wagner", date: "3 September 2026", status: "Due soon", tone: "soon" },
  { title: "Camping stove", person: "Lena Hoffmann", date: "19 September 2026", status: "OK", tone: "ok" },
  { title: "Roof rack", person: "Mara Klein", date: "28 August 2026", status: "Overdue", tone: "late" },
];

const archivedLoans: Loan[] = [
  { title: "Picnic blanket", person: "Sophie Bauer", date: "Returned 21 August 2026", status: "Returned", tone: "ok" },
  { title: "Travel guide", person: "Jonas Richter", date: "Returned 9 August 2026", status: "Returned", tone: "ok" },
  { title: "Bike pump", person: "Tobias Wagner", date: "Returned 2 August 2026", status: "Returned", tone: "ok" },
];

export function OverviewScreen() {
  return (
    <div className="appui">
      <StatusBar />
      <div className="appui-body">
        <div className="appui-title">
          <h4>BorrowBack</h4>
          <span className="appui-add" aria-hidden="true">
            <Plus style={box(19)} strokeWidth={2.6} />
          </span>
        </div>
        <div className="appui-subhead">
          Overview
          <span>
            Due date <ChevronDown style={box(14)} strokeWidth={2} />
          </span>
        </div>
        <div className="appui-cards">
          {activeLoans.map((loan) => (
            <LoanCard key={loan.title} loan={loan} />
          ))}
        </div>
      </div>
      <TabBar active="overview" />
    </div>
  );
}

export function ArchiveScreen() {
  return (
    <div className="appui">
      <StatusBar />
      <div className="appui-body">
        <div className="appui-title">
          <h4 data-sans="true">Archive</h4>
        </div>
        <div className="appui-cards">
          {archivedLoans.map((loan) => (
            <LoanCard key={loan.title} loan={loan} />
          ))}
        </div>
      </div>
      <TabBar active="archive" />
    </div>
  );
}

export function AddLoanScreen() {
  return (
    <div className="appui-stack">
      <OverviewScreen />
      <div className="appui-scrim" aria-hidden="true" />
      <div className="appui-sheet">
        <div className="appui-grabber" aria-hidden="true" />
        <div className="appui-sheetbar">
          <span aria-hidden="true">
            <X style={box(15)} strokeWidth={2.4} />
          </span>
          New Loan
          <span data-confirm="true" aria-hidden="true">
            <Check style={box(15)} strokeWidth={2.6} />
          </span>
        </div>

        <div className="appui-group">
          <b>Loan</b>
          <div className="appui-field">
            Cordless drill
            <span className="appui-caret" aria-hidden="true" />
          </div>
        </div>

        <div className="appui-group">
          <b>Person</b>
          <div className="appui-field" data-placeholder="true">
            Name
          </div>
        </div>

        <div className="appui-group">
          <b>Return</b>
          <div className="appui-field">
            Due on
            <em>3 Sep 2026</em>
          </div>
        </div>
      </div>
    </div>
  );
}
