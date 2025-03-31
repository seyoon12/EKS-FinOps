## Kubecost란
Kubecost는 Kubernetes 클러스터의 리소스 사용량과 클라우드 비용을 분석하고 시각화하는 오픈소스 FinOps 도구입니다.

- 네임스페이스, 워크로드, 라벨 단위로 비용 추적
- CPU, 메모리, 스토리지 사용량 분석
- AWS S3에 저장된 CUR 데이터 연동 가능
- 리소스 낭비 식별 및 최적화 제안
- Prometheus, Grafana와 통합
- 
## Working Process

1. **S3 CUR 설정**  
   `stacks/s3-cur`에서 Terraform으로 AWS Cost and Usage Report(CUR)를 설정하고,  
   비용 데이터를 저장할 S3 버킷을 생성합니다.

2. **비용 수집 대기**  
   AWS에서 S3로 CUR 데이터를 수집하는 데 **최소 하루 이상 소요**됩니다.  
   S3에는 `20250301-20250401/` 형식의 날짜별 폴더가 생성되며,  
   그 안에 비용 CSV 파일이 저장됩니다.

3. **EKS 클러스터 및 노드 구성**  
   `stacks/eks-cluster`, `stacks/eks-selfmanaged-node`를 차례로 실행하여  
   Kubecost를 배포할 EKS 환경을 구성합니다.

4. **Kubecost 설치 및 연동**  
   `ansible-playbook`을 실행하여 Kubecost를 설치하고,  
   IRSA 및 S3 연동을 통해 **S3에 저장된 CUR 데이터를 기반으로 비용 분석**을 수행합니다.

---

## 대시보드 예시

### 1. Kubecost Overview
클러스터 전체의 비용, 리소스 사용률, 비효율 지표 등을 한눈에 확인할 수 있는 종합 대시보드입니다.  
비용 트렌드, 과다/과소 프로비저닝 상태, 리소스 사용 최적화 지표 등을 제공합니다.

![Kubecost Overview](https://github.com/user-attachments/assets/908e55a1-e314-4a0d-9106-b85aa86807a0)

---

### 2. Allocation View
네임스페이스, 워크로드, 라벨 단위로 **비용을 세부적으로 분해**해 보여줍니다.  
S3에 저장된 AWS CUR 데이터를 바탕으로 실제 클라우드 비용을 정확하게 매핑합니다.

![Allocation View](https://github.com/user-attachments/assets/8ac27ca8-7524-43dc-ab3d-521b3d6f77dc)

---

### 3. Saving Insights
비용 최적화 추천을 자동으로 분석하여 보여줍니다.  
과도한 리소스 할당, 사용률 낮은 노드 등을 식별하여 절감 가능 비용을 예측합니다.

![Saving Insights](https://github.com/user-attachments/assets/52b446c4-60d8-4b2b-a68a-eb0322bb2e5b)
