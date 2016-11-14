using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.Cryptography;

class ReplicaHunter
{
    // dir : "_Folk" 598 Mb / 71 file
    // MD5 25s
    // SHA1 9s
    // SHA256 16s
    // SHA384 17s
    // SHA512 19s
    static Dictionary<string, List<string>> state = new Dictionary<string, List<string>>();

    static void Main(string[] args)
    {
        foreach (string path in args)
        {
            addToState(path);
        }
        foreach (KeyValuePair<string, List<string>> it in state)
        {
            if (it.Value.Count > 1)
            {
                Console.WriteLine("{0}\t{1}", it.Value.Count, it.Key);
                foreach (string file in it.Value)
                {
                    Console.WriteLine("\t{0}", file);
                }
            }
        }
    }

    static void addToState(string path)
    {
        foreach (string file in Directory.EnumerateFiles(
    path, "*.*", SearchOption.AllDirectories))
        {
            string metric = fileToMetric(file);
            if (!state.ContainsKey(metric))
            {
                state[metric] = new List<string>();
            }
            state[metric].Add(file);
        }
    }

    static string fileToMetric(string file)
    {
        //using (HashAlgorithm hash = MD5.Create())
        using (HashAlgorithm hash = SHA1.Create())
        //using (HashAlgorithm hash = SHA256.Create())
        //using (HashAlgorithm hash = System.Security.Cryptography.SHA384.Create())
        //using (HashAlgorithm hash = System.Security.Cryptography.SHA512.Create())
        using (Stream fs = File.OpenRead(file))
        {
            byte[] data = hash.ComputeHash(fs);
            return byteArrayToString(data);
        }
        //return Path.GetFileName(file);
    }

    static string byteArrayToString(byte[] array)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < array.Length; i++)
        {
            sb.Append(String.Format("{0:X2}", array[i]));
        }
        return sb.ToString();
    }
}
