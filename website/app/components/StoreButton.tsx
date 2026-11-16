import { APP_STORE_URL } from "@/lib/seo";

export function StoreButton({ variant = "primary" }: { variant?: "primary" | "onDark" | "sm" }) {
  const className =
    variant === "sm"
      ? "btn btn--ghost btn--sm"
      : variant === "onDark"
        ? "btn btn--onDark"
        : "btn btn--primary";

  return (
    <a className={className} href={APP_STORE_URL}>
      Download on the App Store
    </a>
  );
}

