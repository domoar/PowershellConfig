using System.Text.Json;
using System.Text.Json.Serialization;

namespace Helpers;

public class JsonHelper
{
  private static readonly string jsonFile = Path.Combine(
    AppDomain.CurrentDomain.BaseDirectory,
    "installed-tools.json"
  );

  public static List<ToolInfo> LoadTools()
  {
    if (!File.Exists(jsonFile))
      return new List<ToolInfo>();

    var json = File.ReadAllText(jsonFile);
    return JsonSerializer.Deserialize<List<ToolInfo>>(json, GetJsonOptions())
      ?? new List<ToolInfo>();
  }

  public static void SaveTools(List<ToolInfo> tools)
  {
    var json = JsonSerializer.Serialize(tools, GetJsonOptions());
    File.WriteAllText(jsonFile, json);
  }

  private static JsonSerializerOptions GetJsonOptions()
  {
    return new JsonSerializerOptions
    {
      WriteIndented = true,
      PropertyNameCaseInsensitive = true,
      PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
      DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
    };
  }
}
