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

interface RegistrarPropiedad {
  descripcion: string;
  tipoPropiedadId: TipoPropiedad;
  propietarioId: string;
  urlImagen: string;
  pais: string;
  departamento: string;
  direccion: string;
  precio: number;
  etiquetasPropiedad: EtiquetaDTO[];
}

export class RegistrarPropiedadDTO implements RegistrarPropiedad {
  @ApiProperty({
    description: 'Descripción de la propiedad',
    example: 'Casa en venta',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  descripcion: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Id del tipo de propiedad',
    example: 'TPR-VENT',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  tipoPropiedadId: TipoPropiedad;

  //----------------------------------------------
  @ApiProperty({
    description: 'Id del propietario',
    example: 'CLterrainv',
    required: false,
    nullable: true,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsOptional()
  propietarioId: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'URL de la imagen de la propiedad',
    example: 'https://www.inmobiliaria.com/propiedades/casa1.jpg',
    required: false,
    nullable: true,
  })
  @IsString()
  @IsOptional()
  urlImagen: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'País de la propiedad',
    example: 'HONDURAS',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  pais: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Departamento de la propiedad',
    example: 'ATLANTIDA',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  departamento: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Dirección de la propiedad',
    example: 'Colonia Los Pinos',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  direccion: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Precio de la propiedad',
    example: 2501300,
    required: false,
    nullable: true,
  })
  @IsNumber()
  @IsOptional()
  precio: number;

  //----------------------------------------------
  @ApiProperty({
    description: 'Lista de etiquetas de la propiedad',
    required: false,
    nullable: true,
  })
  @IsArray()
  @Type(() => EtiquetaDTO)
  etiquetasPropiedad: EtiquetaDTO[];
}
