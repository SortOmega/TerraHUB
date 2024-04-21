import { MiddlewareConsumer, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { LoggerMiddleware } from './shared/middlewares/logger-middleware';
import { PropiedadesModule } from './modules/propiedades/propiedades.module';
import { DatabaseModule } from './shared/modules/database/database.module';
import { ClientesModule } from './modules/clientes/clientes.module';
import { ContratosModule } from './modules/contratos/contratos.module';
import { PlanillaModule } from './modules/planilla/planilla.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    DatabaseModule,
    PropiedadesModule,
    ClientesModule,
    ContratosModule,
    PlanillaModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LoggerMiddleware).forRoutes('*');
  }
}
