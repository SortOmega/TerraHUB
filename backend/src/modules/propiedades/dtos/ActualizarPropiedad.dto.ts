import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  IsUrl,
  Max,
  MaxLength,
  MinLength,
  ValidateIf,
} from 'class-validator';
import { EtiquetaDTO } from './Etiqueta.dto';
import { Type } from 'class-transformer';
import { RegistrarPropiedad, RegistrarPropiedadDTO } from './RegistrarPropiedad.dto';

interface ActualizarPropiedad extends RegistrarPropiedad {
  propiedadId: string;
}

export class ActualizarPropiedadDTO extends RegistrarPropiedadDTO implements ActualizarPropiedad {
  @ApiProperty({
    description: 'Id del propietario',
    example: 'PRb422b55e',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  propiedadId: string;
}
