import Image from "next/image";

const responsiveSizes = {
  hero: "(max-width: 380px) 224px, (max-width: 560px) 257px, (max-width: 900px) 307px, (max-width: 1080px) 274px, 315px",
  feature: "(max-width: 380px) 224px, (max-width: 560px) 257px, (max-width: 900px) 307px, (max-width: 1080px) 249px, 266px",
} as const;

export function DeviceFrame({
  screenshot,
  alt,
  placement = "feature",
  preload = false,
}: {
  screenshot: string;
  alt: string;
  placement?: keyof typeof responsiveSizes;
  preload?: boolean;
}) {
  return (
    <Image
      className="device"
      src={`/screens/${screenshot}.png`}
      alt={alt}
      width={1319}
      height={2748}
      sizes={responsiveSizes[placement]}
      preload={preload}
    />
  );
}
