using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

class ReplicaHunter
{
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
        return Path.GetFileName(file);
    }
}
