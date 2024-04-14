import { Injectable, Logger, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { APILogger } from 'src/config/logger';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  private logger = new Logger('API ALLAS Repuestos');

  use(request: Request, response: Response, next: NextFunction): void {
    const { method, originalUrl, query, params, body } = request;
    // const userAgent = request.get('user-agent') || '';

    response.on('finish', () => {
      const { statusCode } = response;
      const message = `[${method}] [${originalUrl}] ${statusCode}`;
      //   const contentLength = response.get('content-length');

      if (statusCode === 200 || statusCode === 201 || statusCode === 304) {
        APILogger.logger.info(message);
      } else if (
        statusCode === 400 || //- Bad Request
        statusCode === 408 //- Request Timeout
      ) {
        APILogger.logger.warn(message);
        //APILogger.logger.warn(`body : ${JSON.stringify(body)}`);
        console.log(
          `[QUERY: ${JSON.stringify(query)}], [PARAMS: ${JSON.stringify(
            params
          )}], [BODY: ${JSON.stringify(body)}]`
        );

        // console.log(request);
      } else {
        // this.logger.error(message);
        APILogger.logger.error(message);
        //APILogger.logger.error(`body : ${JSON.stringify(body)}`);
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
