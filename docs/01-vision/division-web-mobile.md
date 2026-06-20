# 05 — División de alcance: Web vs App móvil (Android)

Define qué responsabilidad vive en cada plataforma para el MVP. El backend y la base de datos son **compartidos**: web y app consumen la misma API. La diferencia está en la capa de presentación y en ciertas capacidades específicas del dispositivo.

## 1. Principio rector

> **Backend único, dos clientes.** La lógica de negocio (RN-###), la persistencia y las integraciones (pagos, correo, storage) son del backend. Web y Android son clientes que consumen la misma API REST. Nada de lógica de negocio crítica se duplica en el cliente.

## 2. Matriz de funcionalidades por plataforma

Leyenda: ✅ incluido en MVP · 🔵 fase posterior · ❌ no aplica.

| Funcionalidad | Web pública | Portal web alumno | App Android | Notas |
|---------------|:----------:|:-----------------:|:-----------:|-------|
| Landing (inicio, beneficios, planes, legal, contacto) | ✅ | ❌ | ❌ | La landing es exclusiva de web. La app se descarga ya decidida la compra. |
| Registro y verificación de correo | ✅ | — | ✅ | Ambos clientes; mismo endpoint. |
| Login / logout | — | ✅ | ✅ | |
| Recuperación / cambio de contraseña | ✅ | ✅ | ✅ | |
| MFA opcional | — | ✅ | ✅ | |
| **Checkout y pago** | ✅ | ✅ | 🔵 | **El pago se concentra en web** en MVP (evita comisiones de tienda y simplifica SPEI). La app dirige al checkout web. |
| Renovación de suscripción | ✅ | ✅ | 🔵 | Igual que checkout. |
| Realizar evaluaciones (tema/módulo/materia/general) | — | ✅ | ✅ | Núcleo de la experiencia; en ambos. |
| Simuladores con tiempo | — | ✅ | ✅ | |
| Retroalimentación y explicaciones | — | ✅ | ✅ | |
| Dashboard de progreso | — | ✅ | ✅ | |
| Historial de intentos | — | ✅ | ✅ | |
| Material de apoyo (video/PDF/imagen) embebido | — | ✅ | ✅ | Sin descarga; URLs firmadas. |
| Sistema de referidos (ver código, compartir) | — | ✅ | ✅ | Compartir usa el share nativo de Android. |
| Notificaciones por correo | — | ✅ | ✅ | Las envía el backend; iguales para ambos. |
| Notificaciones push | — | ❌ | 🔵 | Push es ventaja móvil; se evalúa post-MVP. |
| Control de sesión única | — | ✅ | ✅ | Una sola sesión activa entre **todos** los dispositivos (web + app cuentan). |
| **Panel administrativo** | ✅ (web admin) | — | ❌ | El panel es **solo web**. No hay versión móvil. |
| Carga masiva por Excel | ✅ (web admin) | — | ❌ | Solo panel web. |

## 3. Capacidades específicas de cada plataforma

### Web
- **Landing pública y SEO:** única puerta de entrada de marketing; debe ser indexable y rápida.
- **Checkout:** entorno preferente para pagos (tarjeta y SPEI) sin comisiones de tienda de apps.
- **Panel administrativo:** gestión de contenido, usuarios, pagos, reportes y carga masiva.
- **Protección de contenido (límite real):** no se puede impedir la inspección del HTML/recursos que llegan al navegador (RN-062). Se mitiga con tokenización, URLs temporales, watermark y DRM en video.

### App Android
- **FLAG_SECURE:** bloquea capturas/grabación dentro de la app (RF-112). No impide fotografía externa (RN-062).
- **Almacenamiento seguro del token:** uso de almacenamiento cifrado del SO (Keystore).
- **Share nativo:** para compartir el código de referido.
- **Push (futuro):** recordatorios de estudio y avisos de vencimiento.
- **Offline (futuro, fuera de MVP):** la primera fase requiere conexión; el modo offline implica sincronización y mayor superficie de fuga de contenido.

## 4. Lo que es idéntico en ambos clientes (vía API)

Estos comportamientos los garantiza el backend, no el cliente:
- Reglas de suscripción y vigencia (RN-010 a RN-016).
- Validación de pagos por webhook (RN-020 a RN-023).
- Sesión única y expulsión del dispositivo anterior (RN-030 a RN-034) — **web y app comparten el mismo límite de una sesión**.
- Cálculo de métricas, áreas de oportunidad y recomendaciones (RN-053).
- Lógica de referidos y beneficios (RN-040 a RN-045).
- Emisión de correos (RF-090, RF-091).

## 5. Resumen de decisiones de alcance MVP

| Decisión | Justificación |
|----------|---------------|
| Pago **solo en web** en MVP | Evita comisiones de Google Play sobre suscripciones, simplifica SPEI y reduce el alcance móvil inicial. |
| Panel admin **solo web** | No hay caso de uso de administración en movilidad; reduce esfuerzo. |
| App Android es **cliente de consumo** (estudiar + evaluarse) | El valor móvil es practicar en cualquier momento; la compra es un acto puntual que tolera la web. |
| Sesión única **transversal** (web + app) | Cumple la regla de "un solo dispositivo activo" sin importar la plataforma. |
| iOS y push **fuera de MVP** | Primera fase móvil definida como solo Android; push se prioriza después. |

## 6. Implicaciones técnicas de la división

- La **API debe ser cliente-agnóstica**: misma versión sirve a web y Android.
- El **contrato OpenAPI** es la fuente de verdad compartida entre los equipos web y móvil.
- El **control de sesión** se centraliza en backend (lista de sesión activa por cuenta) para que un login en app expulse a la web y viceversa.
- La **entrega de medios** (URLs firmadas/DRM) se diseña una vez en backend y la consumen ambos clientes con sus mecanismos de protección locales (FLAG_SECURE en Android; mitigaciones de navegador en web).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/01-vision/division-web-mobile.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
