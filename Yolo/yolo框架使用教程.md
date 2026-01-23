# YOLO 框架使用教程

## 1. 环境安装

### 1.1 安装 Ultralytics YOLO

```bash
# 使用 pip 安装
pip install ultralytics

# 或使用 conda 安装
conda install -c conda-forge ultralytics
```

### 1.2 验证安装

```python
import ultralytics
ultralytics.checks()
```

## 2. 快速开始

### 2.1 使用预训练模型进行推理

```python
from ultralytics import YOLO

# 加载预训练模型
model = YOLO('yolov8n.pt')  # n(nano), s(small), m(medium), l(large), x(xlarge)

# 对图片进行推理
results = model('image.jpg')

# 对视频进行推理
results = model('video.mp4')

# 对文件夹进行批量推理
results = model('path/to/images/')
```

### 2.2 查看推理结果

```python
# 遍历结果
for result in results:
    boxes = result.boxes  # 边界框
    masks = result.masks  # 分割掩码
    keypoints = result.keypoints  # 关键点
    probs = result.probs  # 分类概率
    
    # 显示结果
    result.show()
    
    # 保存结果
    result.save(filename='result.jpg')
```

## 3. 训练自定义模型

### 3.1 数据集准备

#### 3.1.1 数据集目录结构

```
dataset/
├── images/
│   ├── train/
│   │   ├── image1.jpg
│   │   ├── image2.jpg
│   │   └── ...
│   └── val/
│       ├── image1.jpg
│       └── ...
└── labels/
    ├── train/
    │   ├── image1.txt
    │   ├── image2.txt
    │   └── ...
    └── val/
        ├── image1.txt
        └── ...
```

#### 3.1.2 标注格式

每个图片对应一个 `.txt` 文件，格式为：

```
class_id center_x center_y width height
```

其中所有坐标都是归一化的（0-1 之间）。

示例：
```
0 0.5 0.5 0.3 0.4
1 0.2 0.3 0.1 0.2
```

#### 3.1.3 使用标注工具

推荐使用以下工具进行数据标注：
- **LabelImg**: 简单易用的图像标注工具
- **Roboflow**: 在线标注平台，支持自动转换格式
- **CVAT**: 功能强大的开源标注工具

### 3.2 配置文件

创建数据集配置文件 `dataset.yaml`：

```yaml
# 数据集路径
path: /path/to/dataset  # 数据集根目录
train: images/train     # 训练集路径（相对于 path）
val: images/val         # 验证集路径（相对于 path）
test: images/test       # 测试集路径（可选）

# 类别
nc: 2                   # 类别数量
names: ['person', 'car'] # 类别名称列表
```

### 3.3 开始训练

```python
from ultralytics import YOLO

# 加载模型
model = YOLO('yolov8n.pt')  # 从预训练模型开始
# 或
model = YOLO('yolov8n.yaml')  # 从配置文件构建新模型

# 训练模型
results = model.train(
    data='dataset.yaml',      # 数据集配置文件
    epochs=100,               # 训练轮数
    imgsz=640,                # 输入图像大小
    batch=16,                 # 批次大小
    name='my_model',          # 实验名称
    device=0,                 # GPU 设备（0 或 'cpu'）
    workers=8,                # 数据加载线程数
    patience=50,              # 早停耐心值
    save=True,                # 保存检查点
    save_period=10,           # 每 N 轮保存一次
    cache=False,              # 缓存图像到内存
    pretrained=True,          # 使用预训练权重
    optimizer='auto',         # 优化器（SGD, Adam, AdamW, auto）
    lr0=0.01,                 # 初始学习率
    lrf=0.01,                 # 最终学习率（lr0 * lrf）
    momentum=0.937,           # SGD 动量/Adam beta1
    weight_decay=0.0005,      # 权重衰减
    warmup_epochs=3.0,        # 预热轮数
    warmup_momentum=0.8,      # 预热初始动量
    box=7.5,                  # 边界框损失权重
    cls=0.5,                  # 分类损失权重
    dfl=1.5,                  # DFL 损失权重
    hsv_h=0.015,              # HSV-Hue 增强
    hsv_s=0.7,                # HSV-Saturation 增强
    hsv_v=0.4,                # HSV-Value 增强
    degrees=0.0,              # 旋转增强（度）
    translate=0.1,            # 平移增强
    scale=0.5,                # 缩放增强
    shear=0.0,                # 剪切增强
    perspective=0.0,          # 透视增强
    flipud=0.0,               # 上下翻转概率
    fliplr=0.5,               # 左右翻转概率
    mosaic=1.0,               # Mosaic 增强概率
    mixup=0.0,                # Mixup 增强概率
)
```

### 3.4 命令行训练

```bash
yolo detect train data=dataset.yaml model=yolov8n.pt epochs=100 imgsz=640
```

## 4. 模型验证

```python
from ultralytics import YOLO

# 加载训练好的模型
model = YOLO('runs/detect/my_model/weights/best.pt')

# 验证模型
metrics = model.val()

# 查看指标
print(f"mAP50: {metrics.box.map50}")
print(f"mAP50-95: {metrics.box.map}")
```

命令行方式：
```bash
yolo detect val model=runs/detect/my_model/weights/best.pt data=dataset.yaml
```

## 5. 模型导出

### 5.1 导出为不同格式

```python
from ultralytics import YOLO

model = YOLO('best.pt')

# 导出为 ONNX
model.export(format='onnx')

# 导出为 TensorRT
model.export(format='engine')

# 导出为 CoreML
model.export(format='coreml')

# 导出为 TFLite
model.export(format='tflite')
```

### 5.2 支持的导出格式

| 格式 | 参数 | 用途 |
|------|------|------|
| PyTorch | - | 原始格式 |
| ONNX | `onnx` | 跨平台部署 |
| TensorRT | `engine` | NVIDIA GPU 加速 |
| CoreML | `coreml` | iOS/macOS |
| TFLite | `tflite` | 移动端/嵌入式 |
| OpenVINO | `openvino` | Intel 硬件 |

## 6. 高级功能

### 6.1 多 GPU 训练

```python
# 使用多个 GPU
model.train(data='dataset.yaml', epochs=100, device=[0, 1, 2, 3])
```

### 6.2 断点续训

```python
# 从上次中断的地方继续训练
model = YOLO('runs/detect/my_model/weights/last.pt')
model.train(resume=True)
```

### 6.3 超参数调优

```python
# 使用 Ray Tune 进行超参数搜索
model.tune(
    data='dataset.yaml',
    epochs=30,
    iterations=300,
    optimizer='AdamW',
    plots=False,
    save=False,
    val=False
)
```

### 6.4 跟踪（Tracking）

```python
from ultralytics import YOLO

model = YOLO('yolov8n.pt')

# 使用 ByteTrack 进行目标跟踪
results = model.track(source='video.mp4', tracker='bytetrack.yaml')

# 使用 BoT-SORT 进行目标跟踪
results = model.track(source='video.mp4', tracker='botsort.yaml')
```

## 7. 实用技巧

### 7.1 数据增强建议

- 小数据集（< 1000 张）：增加 mosaic、mixup、hsv 增强
- 大数据集（> 10000 张）：减少增强强度
- 特定场景：根据实际情况调整旋转、翻转等

### 7.2 训练技巧

1. **从预训练模型开始**：使用 COCO 预训练权重可以显著提升效果
2. **合适的图像大小**：640 是默认值，可根据目标大小调整（320-1280）
3. **批次大小**：尽可能大，但不要超出显存
4. **学习率**：默认值通常有效，小数据集可适当降低
5. **早停**：设置 patience 避免过拟合

### 7.3 性能优化

```python
# 使用半精度训练（FP16）
model.train(data='dataset.yaml', amp=True)

# 使用 DDP（分布式数据并行）
# 自动检测并使用多 GPU
model.train(data='dataset.yaml', device=[0, 1])
```

## 8. 常见问题

### 8.1 显存不足

- 减小 batch size
- 减小图像尺寸
- 使用更小的模型（如 yolov8n）
- 启用梯度累积

### 8.2 训练不收敛

- 检查数据标注是否正确
- 降低学习率
- 增加训练轮数
- 检查数据集是否平衡

### 8.3 推理速度慢

- 使用更小的模型
- 导出为 TensorRT 或 ONNX
- 减小输入图像尺寸
- 使用 GPU 推理

## 9. 参考资源

- [Ultralytics 官方文档](https://docs.ultralytics.com/)
- [YOLO GitHub 仓库](https://github.com/ultralytics/ultralytics)
- [YOLO 论文](https://arxiv.org/abs/2305.09972)
- [Roboflow 数据集](https://universe.roboflow.com/)

## 10. 示例代码

### 完整训练流程示例

```python
from ultralytics import YOLO
import os

# 1. 加载模型
model = YOLO('yolov8n.pt')

# 2. 训练
results = model.train(
    data='dataset.yaml',
    epochs=100,
    imgsz=640,
    batch=16,
    name='my_detection_model',
    device=0,
    patience=50,
    save=True,
    plots=True
)

# 3. 验证
metrics = model.val()
print(f"mAP50-95: {metrics.box.map}")

# 4. 推理
results = model.predict(source='test_images/', save=True)

# 5. 导出
model.export(format='onnx')
```

### 实时检测示例

```python
from ultralytics import YOLO
import cv2

model = YOLO('best.pt')

# 打开摄像头
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret:
        break
    
    # 推理
    results = model(frame)
    
    # 绘制结果
    annotated_frame = results[0].plot()
    
    # 显示
    cv2.imshow('YOLO Detection', annotated_frame)
    
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
```
