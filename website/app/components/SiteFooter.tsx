import Image from "next/image";
import Link from "next/link";
import appIcon from "../icon.png";
import { SITE_AUTHOR } from "@/lib/seo";

export function SiteFooter({ home = false }: { home?: boolean }) {
  return (
    <footer className="footer">
        <div className="shell footer-inner">
          <a className="brand" href={home ? "#top" : "/#top"}>
            <Image src={appIcon} alt="" width={26} height={26} />
            BorrowBack
          </a>
          <p style={{ margin: 0 }}>© {new Date().getFullYear()} BorrowBack</p>
          <nav aria-label="Footer navigation">
            <Link href="/privacy">Privacy</Link>
            <a href={home ? "#faq" : "/#faq"}>FAQ</a>
            <a href="mailto:borrowback@itstimo.me">Contact</a>
            <a href={SITE_AUTHOR.url}>{SITE_AUTHOR.name}</a>
          </nav>
        </div>
      </footer>
  );
}
