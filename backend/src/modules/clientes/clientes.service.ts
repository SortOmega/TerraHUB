import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';

@Injectable()
export class ClientesService {
  constructor(private dbService: DatabaseService) {}
}
