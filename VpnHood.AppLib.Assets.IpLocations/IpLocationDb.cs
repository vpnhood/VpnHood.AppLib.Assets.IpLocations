namespace VpnHood.AppLib.Assets.IpLocations;

public static class IpLocationDb
{
    private static readonly Lazy<byte[]> IpLocationZipDataLazy = new(() => Resources.IpLocationZipData);
    public static byte[] IpLocationZipData => IpLocationZipDataLazy.Value;
}