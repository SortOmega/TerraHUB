import { Injectable, Logger, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { APILogger } from 'src/config/logger';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  use(request: Request, response: Response, next: NextFunction): void {
    const { method, originalUrl, query, params, body } = request;

    response.on('finish', () => {
      const { statusCode } = response;
      const message = `[${method}] [${originalUrl}] ${statusCode}`;

      if (statusCode === 200 || statusCode === 201 || statusCode === 304) {
        APILogger.logger.info(message);
      } else if (
        statusCode === 400 || //- Bad Request
        statusCode === 408 //- Request Timeout
      ) {
        APILogger.logger.warn(message);
        console.log(
          `[QUERY: ${JSON.stringify(query)}], [PARAMS: ${JSON.stringify(
            params
          )}], [BODY: ${JSON.stringify(body)}]`
        );
      } else {
        APILogger.logger.error(message);
        console.log(
          `[QUERY: ${JSON.stringify(query)}], [PARAMS: ${JSON.stringify(
            params
          )}], [BODY: ${JSON.stringify(body)}]`
        );
      }
    });

    next();
  }
}
