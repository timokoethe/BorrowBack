import Image from "next/image";

const responsiveSizes = {
  hero: "(max-width: 380px) 224px, (max-width: 560px) 256px, (max-width: 900px) 308px, (max-width: 1080px) 276px, 316px",
  feature: "(max-width: 380px) 224px, (max-width: 560px) 256px, (max-width: 900px) 308px, (max-width: 1080px) 248px, 268px",
} as const;

export function DeviceFrame({
  screenshot,
  alt,
  placement = "feature",
}: {
  screenshot: string;
  alt: string;
  placement?: keyof typeof responsiveSizes;
}) {
  return (
    <Image
      className="device"
      src={`/screens/${screenshot}.png`}
      alt={alt}
      width={1319}
      height={2748}
      sizes={responsiveSizes[placement]}
      loading={placement === "hero" ? "eager" : "lazy"}
      fetchPriority={placement === "hero" ? "high" : undefined}
    />
  );
}
