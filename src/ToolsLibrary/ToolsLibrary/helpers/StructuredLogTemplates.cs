using Microsoft.Extensions.Logging;

namespace Helpers;

public static partial class StructuredLogTemplates {
  [LoggerMessage(
    EventId = 101,
    Level = LogLevel.Information,
    Message = "",
    SkipEnabledCheck = true
  )]
  public static partial void LogPreInstall(
    this ILogger logger, 
    object result
  );

  [LoggerMessage(
    EventId = 102,
    Level = LogLevel.Debug,
    Message = "",
    SkipEnabledCheck = true
  )]
  public static partial void LogInstall(this ILogger logger, object result);

    [LoggerMessage(
    EventId = 103,
    Level = LogLevel.Debug,
    Message = "",
    SkipEnabledCheck = true
  )]
  public static partial void LogPostInstall(this ILogger logger, object result);
}
