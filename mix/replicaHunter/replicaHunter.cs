using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.Cryptography;

class ReplicaHunter
{
	// dir : "_Folk" 598 Mib / 71 file
	// MD5 25s
	// SHA1 9s
	// SHA256 16s
	// SHA384 17s
	// SHA512 19s
	// CRC32 5s

	// dir: "_music" 12.2 GiB / 2662 files
	// CRC32 545s

	// dir: "_misc" 6.3 GiB / 5963 files
	// CRC32 1296s

	static Dictionary<string, List<string>> state = new Dictionary<string, List<string>>();

	static void Main(string[] args)
	{
		DateTime p0 = DateTime.Now;
		foreach (string path in args)
		{
			addToState(path);
		}
		Console.WriteLine ((DateTime.Now - p0).TotalSeconds);
		foreach (List<string> it in 
			state
			.Select (x => x.Value)
			.OrderByDescending (x => x.Count)
			.ToArray())
		{
			if (it.Count > 1)
			{
				Console.WriteLine("{0}", it.Count);
				foreach (string file in it)
				{
					Console.WriteLine("\t{0}", file);
				}
			}
		}
		Console.WriteLine ((DateTime.Now - p0).TotalSeconds);
	}

	static void addToState(string path)
	{
		foreach (string file in Directory.EnumerateFiles(
			path, "*.*", SearchOption.AllDirectories))
		{
			try {
				string metric = fileToMetric(file);
				if (!state.ContainsKey(metric))
				{
					state[metric] = new List<string>();
				}
				state[metric].Add(file);
			} catch (Exception ex) {
				Console.WriteLine ("{0}: {1}", file, ex.Message);
			}
		}
	}

	static string fileToMetric(string file)
	{
		/*
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
		/*/
		using (Stream fs = File.OpenRead(file))
		{
			return string.Format ("{0:X}", CalculateCRC32 (fs));
		}
		//*/
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

	static uint CalculateCRC32(System.IO.Stream stream)
	{
		const int buffer_size = 1024;
		const uint POLYNOMIAL = 0xEDB88320;

		uint result = 0xFFFFFFFF;
		uint Crc32;

		byte[] buffer = new byte[buffer_size];
		uint[] table_CRC32 = new uint[256];

		unchecked
		{
			for (int i = 0; i < 256; i++)
			{
				Crc32 = (uint)i;
				for (int j = 8; j > 0; j--)
				{
					if ((Crc32 & 1) == 1)
						Crc32 = (Crc32 >> 1) ^ POLYNOMIAL;
					else
						Crc32 >>= 1;
				}
				table_CRC32[i] = Crc32;
			}
			int count = stream.Read(buffer, 0, buffer_size);
			while (count > 0)
			{
				for (int i = 0; i < count; i++)
				{
					result = ((result) >> 8)
						^ table_CRC32[(buffer[i])
							^ ((result) & 0x000000FF)];
				}
				count = stream.Read(buffer, 0, buffer_size);
			}
		}
		return ~result;
	}
}
