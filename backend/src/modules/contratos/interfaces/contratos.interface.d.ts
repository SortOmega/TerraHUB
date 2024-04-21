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
