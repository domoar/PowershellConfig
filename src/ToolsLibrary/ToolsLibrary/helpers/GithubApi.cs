using System.Net;
using Microsoft.Extensions.Logging;
using Serilog.Core;

namespace ToolsLibrary.Helpers;

public static class GithubApiHelper{
    public static async Task<(int, string)> GetFromGithub(string repo, HttpClient client, ILogger logger){
        var resp = await client.GetAsync(repo);

        var redirectCodes = new[] {
            HttpStatusCode.Found,
            HttpStatusCode.Moved,
            HttpStatusCode.MovedPermanently
        };

        if (!redirectCodes.Contains(resp.StatusCode))
        {
            logger.LogError("Unhandled statuscode: {StatusCode}", resp.StatusCode);
            return (-1, "NotFound");
        }

        var redirectUrl = resp.Headers.Location?.ToString();
        logger.LogDebug("Redirect URL: {URL}", redirectUrl);

        if (redirectUrl != null && redirectUrl.Contains("/tag/"))
        {
          var version = redirectUrl.Split("/tag/").Last();
          logger.LogDebug("Latest version: {Version}", version);
          return (1, version);
        }

        return (-1, "NotFound");
    }
}