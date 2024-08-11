from dataclasses import asdict, dataclass
from typing import Dict, List, Tuple, Union

from monai import transforms as T


@dataclass
class DataConfig:
    image_key: str = "image"
    label_key: str = "label"
    original_max: int = -50
    original_min: int = 450
    scaled_max: float = 1.0
    scaled_min: float = 0.0
    orientation: float = "RAS"
    spacing: Union[Tuple, List] = (1.5, 1.5, 1.5)
    img_resampler: str = "bilinear"
    label_resampler: str = "nearest"

    def as_dict(self):
        return {k: str(v) for k, v in asdict(self).items()}


# data_cfg = DataConfig()
# loader_transform = [
#     T.LoadImaged(
#         keys=[data_cfg.image_key, data_cfg.label_key],
#         ensure_channel_first=True, ## Necessary for the other transforms
#     ),
#     T.ScaleIntensityRanged(
#         keys=data_cfg.image,
#         a_min=data_cfg.original_max,
#         a_max=data_cfg.original_min,
#         b_min=data_cfg.scaled_min,
#         b_max=data_cfg.scaled_max,
#         clip=True,
#     ),
#     T.CropForegroundd(
#         keys=[data_cfg.image_key, data_cfg.label_key],
#         source_key=data_cfg.image_key),
#     T.Orientationd(
#         keys=[data_cfg.image_key, data_cfg.label_key],
#         axcodes=data_cfg.orientation),
#     T.Spacingd(
#         keys=[data_cfg.image_key, data_cfg.label_key],
#         pixdim=data_cfg.spacing,
#         mode=(data_cfg.img_resampler, data_cfg.label_resampler),
#     ),
# ]
