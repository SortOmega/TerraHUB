import { DatabaseModule } from 'src/shared/modules/database/database.module';
import { ClientesController } from './clientes.controller';
import { ClientesService } from './clientes.service';
import { Module } from '@nestjs/common';

@Module({
  imports: [DatabaseModule],
  controllers: [ClientesController],
  providers: [ClientesService],
  exports: [],
})
export class ClientesModule {}
