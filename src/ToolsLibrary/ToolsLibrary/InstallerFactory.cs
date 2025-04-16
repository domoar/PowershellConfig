using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ToolsLibrary
{
  public static class InstallerFactory
  {
    public static IInstaller CreateInstaller(string toolName)
    {
      return toolName.ToLower() switch
      {
        "git" => new GitInstaller(),
        "powershell" => new PowerShellInstaller(),
        _ => throw new NotSupportedException($"Tool {toolName} is not supported."),
      };
    }
  }
}
