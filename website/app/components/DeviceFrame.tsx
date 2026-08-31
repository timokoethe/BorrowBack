import { existsSync } from "node:fs";
import path from "node:path";
import Image from "next/image";
import type { ReactNode } from "react";

/**
 * iPhone frame authored in iOS points: `--pt` scales the whole thing, so the
 * mock inside keeps authentic type sizes instead of unreadable 6px labels.
 *
 * Drop a real screenshot at `public/screens/<name>.png` (1179 x 2556) and it
 * replaces the mock automatically — no code change needed.
 */
export function DeviceFrame({
  screenshot,
  alt,
  children,
}: {
  screenshot?: string;
  alt: string;
  children: ReactNode;
}) {
  const file = screenshot ? `screens/${screenshot}.png` : undefined;
  const hasScreenshot = file ? existsSync(path.join(process.cwd(), "public", file)) : false;

  return (
    <div className="device" role="img" aria-label={alt}>
      <div className="device-screen">
        <span className="device-island" aria-hidden="true" />
        {hasScreenshot ? (
          <Image src={`/${file}`} alt="" width={1179} height={2556} sizes="400px" />
        ) : (
          children
        )}
      </div>
    </div>
  );
}
