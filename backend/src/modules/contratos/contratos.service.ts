import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';

@Injectable()
export class ContratosService {
  constructor(private dbService: DatabaseService) {}
}
