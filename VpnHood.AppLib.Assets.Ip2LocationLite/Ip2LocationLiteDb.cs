namespace VpnHood.AppLib.Assets.Ip2LocationLite;

public static class Ip2LocationLiteDb
{
    private static readonly Lazy<byte[]> ZipDataLazy = new(() => Resources.IpLocationZipData);
    public static byte[] ZipData => ZipDataLazy.Value;
}
