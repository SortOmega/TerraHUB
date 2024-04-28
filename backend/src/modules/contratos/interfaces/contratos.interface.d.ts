interface SolicitudInmueble {
  solicitudId: string;
  tipoSolicitudId: string;
  tipoSolicitudDescripcion: string;
  descripcionSolicitud: string;
  clienteId: string;
  nombreCliente: string;
  identidad: string;
  fechaCreacion: Date;
  empleadoPlazaEncargado: string;
  nombreEmpleadoEncargado: string;
  estadoId: string;
  estadoDescripcion: string;
  fechaProcesada: Date;
  empleadoTerminoSolicitud: string;
}

interface VentaInmueble {
  ventaId: string;
  fechaVenta: Date;
  propiedadId: string;
  descripcionPropiedad: string;
  precioVenta: number;
  propietarioAntiguoId: string;
  nombrePropietarioAntiguo: string;
  propietarioNuevoId: string;
  nombrePropietarioNuevo: string;
  empleadoVendedorId: string;
  nombreEmpleadoVendedor: string;
}

interface CompraInmueble {
  compraId: string;
  fechaCompra: Date;
  propiedadId: string;
  descripcionPropiedad: string;
  precioCompra: number;
  propietarioAntiguoId: string;
  nombrePropietarioAntiguo: string;
  propietarioNuevoId: string;
  nombrePropietarioNuevo: string;
  empleadoCompradorId: string;
  nombreEmpleadoComprador: string;
}
