using System;
using System.IO;
using System.Reflection;
using System.Runtime.Loader;

internal static class Program
{
    // args[0]: RimWorld's Managed folder. args[1]: VEF's Assemblies folder.
    private static int Main(string[] args)
    {
        AssemblyLoadContext.Default.Resolving += (context, name) =>
        {
            foreach (string dir in new[] { args[0], args[1] })
            {
                string path = Path.Combine(dir, name.Name + ".dll");
                if (File.Exists(path)) return context.LoadFromAssemblyPath(path);
            }

            return null;
        };
        try
        {
            Assembly.GetExecutingAssembly().GetType("QuietNewFactionsTests.BehaviorTests")
                .GetMethod("Run").Invoke(null, null);
            return 0;
        }
        catch (Exception e) { Console.Error.WriteLine(e.InnerException ?? e); return 1; }
    }
}
