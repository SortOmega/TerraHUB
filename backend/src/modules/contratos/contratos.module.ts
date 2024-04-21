import { Module } from '@nestjs/common';
import { ContratosController } from './contratos.controller';
import { ContratosService } from './contratos.service';
import { DatabaseModule } from 'src/shared/modules/database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [ContratosController],
  providers: [ContratosService],
})
export class ContratosModule {}
