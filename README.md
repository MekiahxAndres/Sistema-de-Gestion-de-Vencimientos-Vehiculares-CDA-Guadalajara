# Sistema de Gestión de Vencimientos Vehiculares – CDA Guadalajara  
## 🛠️ Technologies Used

- Oracle SQL Developer Data Modeler  
- SQL  
- PL/SQL  
- Relational database design  

---

## 🧠 Learning Outcomes

This project strengthened my foundations in:

- Database design and relational modeling  
- Structured query development (SQL & PL/SQL)  
- Data-driven reporting and information systems  

It also expanded my interest in:

- Data analytics  
- Information systems engineering  

---

## 🎓 Academic Context

This project was developed as part of a university course:  
**Data-Intensive Systems I**

---
## Integrantes  
- **Andrés Felipe Rivas Ospina** – A00406656  
- **Fredy Alejandro Cifuentes** – A00407638  
- **Isabella Londoño Lerma** – A00406690  
- **María Juliana Galvis** – A00406954  

---

## Contexto del Caso  
Este proyecto surge como **adaptación a una problemática real** del *Centro de Diagnóstico Automotor Guadalajara (CDA Guadalajara)*.  
Actualmente, la institución enfrenta dificultades para realizar un control eficiente de los **vencimientos del SOAT y la revisión técnico-mecánica (RTM)** de los vehículos que atiende.  

La falta de una herramienta centralizada genera riesgos como:  
- Pérdida de clientes por ausencia de recordatorios.  
- Escasa trazabilidad de servicios realizados.  
- Baja efectividad en campañas de retención.  

---

## Objetivo General  
Implementar un **sistema de información** que centralice y gestione la información técnica, legal y de contacto de los vehículos atendidos en el CDA Guadalajara, permitiendo:  
- Registrar y actualizar la información de cada vehículo y propietario.  
- Detectar automáticamente vencimientos próximos de SOAT y RTM.  
- Identificar clientes que no han regresado en más de 12 meses.  
- Generar alertas, reportes y consultas útiles para la toma de decisiones y campañas comerciales.  

---

## Desarrollo del Proyecto  
El sistema se desarrollará siguiendo una metodología incremental, garantizando que cada iteración entregue funcionalidades reales y útiles.  

---

## Información que Gestionará el Sistema  
El modelo de datos contempla **4 entidades principales**:  

### Vehículo  
- Placa (única)  
- Marca  
- Línea  
- Modelo  
- Tipo de servicio  
- Cilindraje  
- Año de fabricación  

### Propietario  
- Nombre y apellidos  
- Cédula / NIT  
- Teléfono  
- Correo electrónico  
- Dirección  

### Servicio  
- Fecha de atención  
- Tipo de servicio (RTM / inspección)  
- Resultado  
- Observaciones  

### Documento  
- Tipo (SOAT / RTM)  
- Fecha de emisión  
- Fecha de vencimiento  
- Estado (vigente / por vencer / vencido)  

---

## Reportes Clave  

1. **Vencimientos Próximos**  
   Lista de vehículos cuyo SOAT o RTM vence en los próximos 30 días.  

2. **Vehículos Sin Retorno**  
   Lista de clientes que no han regresado en más de 12 meses desde su última visita.  

3. **Historial Técnico por Vehículo**  
   Consulta detallada con fechas de revisiones, pólizas, estado actual y observaciones.  

---

## Requerimientos Funcionales  

- **RF1 – Registrar un nuevo vehículo**  
  Permitir almacenar la información técnica y su propietario.  

- **RF2 – Registrar revisión técnico-mecánica**  
  Guardar fecha, resultado y observaciones de cada revisión.  

- **RF3 – Registrar SOAT**  
  Asociar póliza, aseguradora y fechas de vigencia.  

- **RF4 – Generar notificaciones automáticas**  
  Alertar vencimientos de SOAT y RTM.  

- **RF5 – Consultar historial de un vehículo**  
  Visualizar información histórica de revisiones y seguros.  

- **RF6 – Reportar vehículos inactivos**  
  Identificar clientes que llevan más de un año sin regresar.  

---

## Alcance Inicial  
La primera versión del sistema permitirá:  
- Optimizar procesos internos del CDA.  
- Garantizar seguimiento proactivo a clientes.  
- Facilitar información estratégica para la **retención** de usuarios.  

En el mediano plazo, el sistema será un **activo clave** para:  
- Fortalecer la relación con los clientes.  
- Aumentar la eficiencia operativa.  
- Incrementar el volumen de servicios prestados.  
