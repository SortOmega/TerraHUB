enum EnumTipoPropiedad {
  VENTA = 'TPR-VENT',
  ALQUILER = 'TPR-ALQU',
  COMPRA = 'TPR-COMP',
}

interface EtiquetaPropiedad {
  etiquetaId: string;
  nombreEtiqueta: string;
  esCuantificable: boolean;
}

interface EtiquetaPropiedadLinked extends EtiquetaPropiedad {
  propiedadId: string;
  cantidad: number;
}

interface TipoPropiedad {
  tipoPropiedadId: EnumTipoPropiedad;
  descripcion: string;
}

interface Propiedad {
  propiedadId: string;
  descripcion: string;
  tipoPropiedadId: string;
  tipoPropiedadDesc: string;
  propietarioId: string;
  propietarioNombre: string;
  propietarioDNI: string;
  urlImagen: string;
  pais: string;
  departamento: string;
  direccion: string;
  precio: number;
}
