local id = 'OpenET/SSEBOP/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'OpenET CONUS SSEBop Monthly Evapotranspiration v2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Operational Simplified Surface Energy Balance (SSEBop)

    The Operational Simplified Surface Energy Balance (SSEBop) model by Senay
    et al. (2013, 2017) is a thermal-based simplified surface energy model for
    estimating actual ET based on the principles of satellite psychrometry
    (Senay 2018). The OpenET SSEBop implementation uses land surface temperature
    (Ts) from Landsat (Collection 2 Level-2 Science Products) with key model
    parameters (cold/wet-bulb reference, Tc, and surface psychrometric
    constant, 1/dT) derived from a combination of observed surface temperature,
    normalized difference vegetation index (NDVI), climatological average
    (1980-2017) daily maximum air temperature (Ta, 1-km) from Daymet, and
    net radiation data from ERA-5. This model implementation uses the Google
    Earth Engine processing framework for connecting key SSEBop ET functions
    and algorithms together when generating both intermediate and aggregated ET
    results. A detailed study and evaluation of the SSEBop model across CONUS
    (Senay et al., 2022) informs both cloud implementation and assessment for
    water balance applications at broad scales. Notable model (v0.2.6)
    enhancements and performance against previous versions include additional
    compatibility with Landsat 9 (launched Sep 2021), global model
    extensibility, and improved parameterization of SSEBop using
    FANO (Forcing and Normalizing Operation) to better estimate ET
    in all landscapes and all seasons regardless of vegetation cover density,
    thereby improving model accuracy by avoiding extrapolation of Tc to
    non-calibration regions.

    [Additional information](https://openetdata.org/methodologies/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'landsat_derived',
    'monthly',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://openetdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126, 25, -66, 50, '2016-01-01T00:00:00Z', null),
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: 'SSEBop ET value',
        'gee:units': units.millimeter,
      },

      {
        name: 'count',
        description: 'Number of cloud free values',
        'gee:units': units.count,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET SSEBop Monthly ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1400,
            ],
            palette: [
              '9e6212',
              'ac7d1d',
              'ba9829',
              'c8b434',
              'd6cf40',
              'bed44b',
              '9fcb51',
              '80c256',
              '61b95c',
              '42b062',
              '45b677',
              '49bc8d',
              '4dc2a2',
              '51c8b8',
              '55cece',
              '4db4ba',
              '459aa7',
              '3d8094',
              '356681',
              '2d4c6e',
            ],
            bands: [
              'et',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Senay, G.B., Parrish, G.E., Schauer, M., Friedrichs, M., Khand, K., Boiko,
    O., Kagone, S., Dittmeier, R., Arab, S. and Ji, L., 2023. Improving the
    Operational Simplified Surface Energy Balance Evapotranspiration Model Using
    the Forcing and Normalizing Operation. Remote Sensing, 15(1), p.260.
  |||,
  'sci:publications': [
    {
      citation: |||
          Senay, G.B., Bohms, S., Singh, R.K., Gowda, P.H., Velpuri, N.M.,
          Alemu, H. and Verdin, J.P., 2013. Operational evapotranspiration
          mapping using remote sensing and weather datasets: A new
          parameterization for the SSEB approach. JAWRA Journal of the
          American Water Resources Association, 49(3), pp.577-591.
      |||,
    },
    {
      citation: |||
          Senay, G.B., Schauer, M., Friedrichs, M., Velpuri, N.M. and Singh, R
          .K., 2017. Satellite-based water use dynamics using historical
          Landsat data (1984–2014) in the southwestern United States. Remote
          Sensing of Environment, 202, pp.98-112.
      |||,
    },
    {
      citation: |||
          Senay, G.B., 2018. Satellite psychrometric formulation of the
          Operational Simplified Surface Energy Balance (SSEBop) model for
          quantifying and mapping evapotranspiration. Applied Engineering in
          Agriculture, 34(3), pp.555-566.
      |||,
    },
    {
      citation: |||
          Senay, G.B., Friedrichs, M., Morton, C., Parrish, G.E., Schauer, M
          ., Khand, K., Kagone, S., Boiko, O. and Huntington, J., 2022.
          Mapping actual evapotranspiration using Landsat for the
          conterminous United States: Google Earth Engine implementation and
          assessment of the SSEBop model. Remote Sensing of Environment, 275,
          p.113011.
      |||,
    },
   ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
