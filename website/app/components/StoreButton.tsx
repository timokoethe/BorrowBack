import { APP_STORE_URL } from "@/lib/seo";

export function StoreButton({ variant = "primary" }: { variant?: "primary" | "onDark" | "sm" }) {
  const className =
    variant === "sm"
      ? "btn btn--ghost btn--sm"
      : variant === "onDark"
        ? "btn btn--onDark"
        : "btn btn--primary";

  if (!APP_STORE_URL) {
    return <span className={`${className} btn--unavailable`}>Coming soon on the App Store</span>;
  }

  return (
    <a className={className} href={APP_STORE_URL}>
      Download on the App Store
    </a>
  );
}

