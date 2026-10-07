import Image from "next/image";
import Link from "next/link";
import appIcon from "../icon.png";
import { StoreButton } from "./StoreButton";

export function SiteHeader({ home = false }: { home?: boolean }) {
  return (
    <header className="header">
        <div className="shell header-inner">
          <a className="brand" href={home ? "#top" : "/#top"} aria-label="BorrowBack home">
            <Image src={appIcon} alt="" width={30} height={30} priority />
            BorrowBack
          </a>
          <nav className="nav" aria-label="Main navigation">
            <a href={home ? "#how" : "/#how"}>How it works</a>
            <a href={home ? "#faq" : "/#faq"}>FAQ</a>
            <Link href="/privacy" aria-current={home ? undefined : "page"}>Privacy</Link>
          </nav>
          <StoreButton variant="sm" />
        </div>
      </header>
  );
}
