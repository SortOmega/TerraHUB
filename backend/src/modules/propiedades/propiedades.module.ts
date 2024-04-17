import { Module } from '@nestjs/common';
import { PropiedadesController } from './propiedades.controller';
import { PropiedadesService } from './propiedades.service';
import { DatabaseModule } from 'src/shared/modules/database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [PropiedadesController],
  providers: [PropiedadesService],
})
export class PropiedadesModule {}
