using Microsoft.Extensions.Logging;
using ToolsLibrary;

namespace Helpers;

public static partial class StructuredLogTemplates
{
  [LoggerMessage(
    EventId = 101,
    Level = LogLevel.Information,
    Message = "Starting install routine for {Type}",
    SkipEnabledCheck = true
  )]
  public static partial void LogStart(this ILogger logger, Type type);

  [LoggerMessage(
    EventId = 102,
    Level = LogLevel.Information,
    Message = "Finished preinstall routine for {Type}",
    SkipEnabledCheck = true
  )]
  public static partial void LogFinish(this ILogger logger, Type type);

  public static void LogStart<T>(this ILogger logger)
  {
    logger.LogStart(typeof(T));
  }

  public static void LogFinish<T>(this ILogger logger)
  {
    logger.LogFinish(typeof(T));
  }
}
