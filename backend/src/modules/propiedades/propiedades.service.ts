import { Injectable } from '@nestjs/common';
// import { CreatePropiedadesDto } from './dto/create-propiedades.dto';
// import { UpdatePropiedadesDto } from './dto/update-propiedades.dto';

@Injectable()
export class PropiedadesService {
  // create(createPropiedadesDto: CreatePropiedadesDto) {
  //   return 'This action adds a new propiedades';
  // }

  findAll() {
    return `This action returns all propiedadess`;
  }

  findOne(id: number) {
    return `This action returns a #id propiedades`;
  }

  // update(id: number, updatePropiedadesDto: UpdatePropiedadesDto) {
  //   return `This action updates a #id propiedades`;
  // }

  remove(id: number) {
    return `This action removes a #id propiedades`;
  }
}
