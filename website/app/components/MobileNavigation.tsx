"use client";

import { useRef, useState } from "react";
import Link from "next/link";
import { Menu, X } from "lucide-react";

export function MobileNavigation({ home }: { home: boolean }) {
  const [open, setOpen] = useState(false);
  const toggle = useRef<HTMLButtonElement>(null);

  return (
    <div
      className="mobile-nav"
      onBlur={(event) => {
        if (!event.currentTarget.contains(event.relatedTarget)) setOpen(false);
      }}
      onKeyDown={(event) => {
        if (event.key === "Escape") {
          setOpen(false);
          toggle.current?.focus();
        }
      }}
    >
      <button
        ref={toggle}
        className="nav-toggle"
        type="button"
        aria-expanded={open}
        aria-controls="mobile-navigation"
        onClick={() => setOpen(!open)}
      >
        {open ? <X size={18} strokeWidth={1.5} aria-hidden="true" /> : <Menu size={18} strokeWidth={1.5} aria-hidden="true" />}
        Menu
      </button>
      <nav
        id="mobile-navigation"
        className="mobile-nav-links"
        aria-label="Mobile navigation"
        hidden={!open}
        onClick={() => setOpen(false)}
      >
        <a href={home ? "#how" : "/#how"}>How it works</a>
        <a href={home ? "#faq" : "/#faq"}>FAQ</a>
        <Link href="/privacy" aria-current={home ? undefined : "page"}>Privacy</Link>
      </nav>
    </div>
  );
}
