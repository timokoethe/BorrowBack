import Image from "next/image";
import Link from "next/link";
import { ArrowLeft, CalendarDays, PackageOpen, UserRound } from "lucide-react";
import appIcon from "./icon.png";

export default function NotFound() {
  return (
    <div className="not-found-shell">
      <a className="skip-link" href="#not-found">
        Skip to page not found message
      </a>

      <header className="not-found-header shell">
        <Link className="brand" href="/" aria-label="BorrowBack home">
          <Image src={appIcon} alt="" width={34} height={34} priority />
          BorrowBack
        </Link>
      </header>

      <main className="not-found-page shell" id="not-found">
        <div className="not-found-copy">
          <p className="eyebrow">Error 404</p>
          <h1 className="display">
            This page didn&rsquo;t
            <br />
            <span className="accent">make it back.</span>
          </h1>
          <p className="lead">
            The address may have changed, or the page never existed. Either way,
            we know the way home.
          </p>
          <Link className="btn btn--primary" href="/">
            <ArrowLeft size={17} strokeWidth={2.2} aria-hidden="true" />
            Back to BorrowBack
          </Link>
        </div>

        <div className="missing-page-visual" aria-hidden="true">
          <span className="missing-page-number">404</span>
          <div className="missing-loan-card">
            <div className="missing-loan-thumbnail">
              <PackageOpen size={44} strokeWidth={1.7} />
            </div>
            <div className="missing-loan-details">
              <div className="missing-loan-title">
                <strong>Missing page</strong>
                <span>Overdue</span>
              </div>
              <p>
                <UserRound size={16} strokeWidth={1.9} />
                Somewhere on the internet
              </p>
              <p>
                <CalendarDays size={16} strokeWidth={1.9} />
                Due back a while ago
              </p>
            </div>
          </div>
        </div>
      </main>

      <footer className="not-found-footer shell">
        <p>© {new Date().getFullYear()} BorrowBack</p>
        <Link href="/privacy">Privacy</Link>
      </footer>
    </div>
  );
}
